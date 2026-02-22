locals {
    
    # Lambda roles:
        lambda_roles ={
            tf_LambdaExecutionRole = {}

        }

    # Lambdas definition:
        lambdas = {
            rekognition = {
                function_name = "tf_rekognition"
                zip = "rekognition.zip"
                role = "tf_LambdaExecutionRole"
                permissions = [
                    "s3:PutObject",
                    "s3:ListBucket",
                    "rekognition:DetectFaces"
                ]
                route = "POST /analyze"
            }

            presign = {
                function_name = "tf_presign"
                zip = "presign.zip"
                role = "tf_LambdaExecutionRole"
                permissions = [
                    "s3:GetObject",
                ]
                route = "GET /upload-url"
            }
    }
}