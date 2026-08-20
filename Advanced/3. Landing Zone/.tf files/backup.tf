# Vault definition:
    resource "aws_backup_vault" "main" {
      name = "landing-zone-backup-vault"
}

# Backup plan
    resource "aws_backup_plan" "main" {
      name = "landing-zone-backup-plan"

      rule {
        rule_name = "daily-backup"
        target_vault_name = aws_backup_vault.main.name

        schedule = "cron(0 2 * * ? *)"

        lifecycle {
          delete_after = 30
        }
      }
}