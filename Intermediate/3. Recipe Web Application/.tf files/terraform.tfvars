IAM_roles = {
  LambdaExecutionReadRole   = "tf_LambdaExecutionReadRole"
  LambdaExecutionWriteRole  = "tf_LambdaExecutionWriteRole"
  LambdaExecutionDeleteRole = "tf_LambdaExecutionDeleteRole"
  LambdaExecutionUpdateRole = "tf_LambdaExecutionUpdateRole"
  LambdaExecutionAuthRole   = "tf_LambdaExecutionAuthRole"
  LambdaExecutionHCRole     = "tf_LambdaExecutionHCRole"
}

LambdaExecBasicRole = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

# Role policy mapping:
role_policy_map = {
  LambdaExecutionReadRole = [
    "DDBReadPolicy"
  ]
  LambdaExecutionWriteRole = [
    "DDBWritePolicy"
  ]
  LambdaExecutionDeleteRole = [
    "DDBDeletePolicy"
  ]
  LambdaExecutionUpdateRole = [
    "DDBUpdatePolicy"
  ]
}

