resource "aws_dynamodb_table" "valeroku_recipes" {
  name         = "Valeroku-recipes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id" // Partition key

  attribute {
    name = "id"
    type = "S"
  }
}

