# DynamoDB creation (PK: project_slug, SK: created_at):
    resource "aws_dynamodb_table" "feedback" {
        
        name = "PortfolioFeedback"
        billing_mode = "PAY_PER_REQUEST"

        hash_key = "project_slug"
        range_key = "created_at"

        attribute {
          name = "project_slug"
          type = "S"
        }
      
        attribute {
          name = "created_at"
          type = "S"
        }
}