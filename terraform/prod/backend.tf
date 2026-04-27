terraform {
    backend "s3" { 
        bucket = "ugochi-project1-state-euc1"
        key     = "note-stack-app/ecs/terraform.tfstate"
        dynamodb_table = "ugochi-notestack-lock"
        region = "eu-central-1"
        encrypt = true
        use_lockfile = true
    }
}