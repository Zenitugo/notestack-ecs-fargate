FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN pip install  -r requirements.txt

EXPOSE 8000

CMD [ "uvicorn", "main:app", "--reload",  "--host", "0.0.0.0", "--port", "8000" ]
