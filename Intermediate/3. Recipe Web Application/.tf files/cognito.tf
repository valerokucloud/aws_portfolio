// Authentication. Cognito User Pool:
resource "aws_cognito_user_pool" "chapter4_cognito_user_pool" {
  name                     = "tf_chapter4_cognito_user_pool"
  mfa_configuration        = "OFF"
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length    = 6
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  /*
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  */

# 🔹 INVITACIÓN DE USUARIO (EMAIL PERSONALIZADO)
  admin_create_user_config {
    allow_admin_create_user_only = true

    invite_message_template {
      email_subject = "Welcome to Recipe Application!"
      email_message = <<EOT
        
      <p>Welcome to Recipe App!</p>
      <br>
      ===============================================================
      <p><strong>ACCOUNT INFORMATION</strong></p>

      <p>
        Your account has been created.
      </p>

      <p>
        User: <strong> {username} </strong><br>
        Temporary password: <strong> {####} </strong>
      </p>
      ===============================================================
      
      <p>
        <strong>NEXT STEPS</strong>
      </p>

      <p>
        Please log in and change your password on your first visit.
      </p>
      ===============================================================
      
      <p>
        <br>
        Kind regards,<br>
        Recipe App Team
      </p>

        EOT

        # MANDATORY even if not used:
          sms_message = "User {username}, temp password {####}"
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  schema {
    attribute_data_type = "String"
    name                = "email"
    mutable             = true
    required            = true
  }
}

// Cognito User pool client:
resource "aws_cognito_user_pool_client" "chapter4_cognito_user_pool_client" {
  name            = "tf_chapter4_cognito_user_pool_client"
  user_pool_id    = aws_cognito_user_pool.chapter4_cognito_user_pool.id
  generate_secret = false
}

// Cognito User pool user (optional - for testing purposes):
resource "aws_cognito_user" "user_cognito" {
  user_pool_id = aws_cognito_user_pool.chapter4_cognito_user_pool.id
  username     = "admin"
  attributes = {
    email = "example@example.com",
  }
  desired_delivery_mediums = ["EMAIL"]
}
