resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
    # If the billing_mode is "provisioned" the read&write fields are required:
        billing_mode   = "PROVISIONED"
        read_capacity  = 20
        write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

    # Deleting items from the table after a specified timestamp. 
    # It's useful for managing data lifecycle, such as expiring session data, temporary records, or cache entries, without manual deletion.
        ttl {
            attribute_name = "TimeToExist"
            enabled        = true
        }

    # Index with its own partition key and opt. sort key, allows you to query data on non-primary attributes: 
        global_secondary_index {
            name               = "GameTitleIndex"
            hash_key           = "GameTitle"
            range_key          = "TopScore"
            write_capacity     = 10
            read_capacity      = 10
            # Attributes into the index (ALL, INCLUDE, KEYS_ONLY):
                projection_type    = "INCLUDE"
            non_key_attributes = ["UserId"]
        }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}