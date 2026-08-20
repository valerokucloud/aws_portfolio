# IAM Access Analyzer account creation:
resource "aws_accessanalyzer_analyzer" "external_access" {
  analyzer_name = "external-access-analyzer"
  type          = "ACCOUNT"
}