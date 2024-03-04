resource "aws_dynamodb_table" "dynamodb_table" {
  count = length(var.db_tables)

  name         = var.db_tables[count.index]
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.type
  }

  tags = {
    Name = "${var.name}-dynamodb-table"
  }
}
