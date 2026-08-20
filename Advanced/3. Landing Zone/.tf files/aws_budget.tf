# AWS weekly Budget (USD):
    resource "aws_budgets_budget" "monthly" {
    name         = "monthly-budget"
    budget_type  = "COST"
    limit_amount = "20"
    limit_unit   = "USD"
    time_unit    = "MONTHLY"

    notification {
        comparison_operator        = "GREATER_THAN"
        threshold                   = 30
        threshold_type              = "PERCENTAGE"
        notification_type           = "FORECASTED"
        subscriber_email_addresses = [
        var.budget_email
        ]
    }

    notification {
        comparison_operator        = "GREATER_THAN"
        threshold                   = 50
        threshold_type              = "PERCENTAGE"
        notification_type           = "ACTUAL"
        subscriber_email_addresses = [
        var.budget_email
        ]
    }
}