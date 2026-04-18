from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import psycopg2
import psycopg2.extras
import os
from datetime import datetime
from contextlib import asynccontextmanager

app = FastAPI(title="Notes API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Database connection
def get_db():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        database=os.getenv("DB_NAME", "notesdb"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "postgres"),
    )
    return conn

# Create table on startup
@asynccontextmanager
async def lifespan(app: FastAPI):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("""
        CREATE TABLE IF NOT EXISTS notes (
            id SERIAL PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            content TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    cur.close()
    conn.close()
    yield

app = FastAPI(title="Notes API", lifespan=lifespan)


# Models
class NoteCreate(BaseModel):
    title: str
    content: str

class Note(BaseModel):
    id: int
    title: str
    content: str
    created_at: datetime

# Routes
@app.get("/")
def root():
    return {"message": "Notes API is running"}

@app.get("/notes", response_model=List[Note])
def get_notes():
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute("SELECT * FROM notes ORDER BY created_at DESC")
    notes = cur.fetchall()
    cur.close()
    conn.close()
    return notes

@app.post("/notes", response_model=Note)
def create_note(note: NoteCreate):
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
    cur.execute(
        "INSERT INTO notes (title, content) VALUES (%s, %s) RETURNING *",
        (note.title, note.content)
    )
    new_note = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    return new_note

@app.delete("/notes/{note_id}")
def delete_note(note_id: int):
    conn = get_db()
    cur = conn.cursor()
    cur.execute("DELETE FROM notes WHERE id = %s RETURNING id", (note_id,))
    deleted = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    if not deleted:
        raise HTTPException(status_code=404, detail="Note not found")
    return {"message": f"Note {note_id} deleted"}
