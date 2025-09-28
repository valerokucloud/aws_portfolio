
resource "aws_s3_bucket" "valeroku_mycv" {
  bucket = "valeroku-mycv"
}

resource "aws_s3_bucket_website_configuration" "mycv_sh_config" {
  bucket = aws_s3_bucket.valeroku_mycv.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}



