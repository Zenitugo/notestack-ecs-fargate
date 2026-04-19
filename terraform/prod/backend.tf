terraform {
    backend = "ugochi-project1-state"
    key     = "note-stack-app/ecs/terraform.tfstate"
    dynamodb_table = "ugochi-notestack-lock"
    region = "eu-central-1"
    encrypt = true
}