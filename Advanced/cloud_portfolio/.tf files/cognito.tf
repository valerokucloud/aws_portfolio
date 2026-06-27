# Cognito User pool creation (v2): storing user accounts, manages registration...
    resource "aws_cognito_user_pool" "portfolio_v2" {

        name = "portfolio-user-pool-v2"
        auto_verified_attributes = ["email"]
        username_attributes = ["email"]

        schema {
            attribute_data_type = "String"
            name                = "given_name"
            required            = true
            mutable             = true
        }

        schema {
            attribute_data_type = "String"
            name                = "family_name"
            required            = true
            mutable             = true
        }

        password_policy {
            minimum_length    = 8
            require_lowercase = true
            require_uppercase = true
            require_numbers   = true
            require_symbols   = false

        }
}

# Connects the app to the User Pool. Defines how users auth, which URLs are used after sign in/out...
resource "aws_cognito_user_pool_client" "portfolio_v2" {

  name = "portfolio-client-v2"
  user_pool_id = aws_cognito_user_pool.portfolio_v2.id
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH"
  ]

  allowed_oauth_flows_user_pool_client = true

  allowed_oauth_flows = [
    "implicit"
  ]

  allowed_oauth_scopes = [
    "openid",
    "email",
    "profile"
  ]

  callback_urls = [
    "http://localhost:4321/callback.html",
    "https://['YOUR_DOMAIN']/callback.html"
  ]

  logout_urls = [
    "http://localhost:4321",
    ['YOUR_DOMAIN'].xxx
  ]

  supported_identity_providers = ["COGNITO"]
}

# Creates the auth URL used by Cognito. Provide the hosted pages where users can sign in, register and log out.
    resource "aws_cognito_user_pool_domain" "portfolio" {
      domain = "['YOUR_DOMAIN']"
      user_pool_id = aws_cognito_user_pool.portfolio_v2.id
}
