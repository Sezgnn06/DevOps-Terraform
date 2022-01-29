#s3 bucket

resource "aws_s3_bucket" "b4" {
  bucket = "s3-terraform-bucket-lab4"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_object" "object1" {
  for_each     = fileset("myfiles/default/", "*")
  bucket       = aws_s3_bucket.b4.id
  key          = "default/${each.value}"
  source       = "myfiles/default/${each.value}"
  etag         = filemd5("myfiles/default/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "object2" {
  for_each     = fileset("myfiles/itmeme/", "*")
  bucket       = aws_s3_bucket.b4.id
  key          = "itmeme/${each.value}"
  source       = "myfiles/itmeme/${each.value}"
  etag         = filemd5("myfiles/itmeme/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "object3" {
  for_each     = fileset("myfiles/video/", "*")
  bucket       = aws_s3_bucket.b4.id
  key          = "video/${each.value}"
  source       = "myfiles/video/${each.value}"
  etag         = filemd5("myfiles/video/${each.value}")
  content_type = "text/html"
}

resource "aws_s3_bucket_policy" "prod_website" {
  bucket = aws_s3_bucket.b4.id
  policy = <<POLICY
{    
    "Version": "2012-10-17",    
    "Statement": [        
      {            
          "Sid": "PublicReadGetObject",            
          "Effect": "Allow",            
          "Principal": "*",            
          "Action": [                
             "s3:GetObject"            
          ],            
          "Resource": [
             "arn:aws:s3:::${aws_s3_bucket.b4.id}/*"            
          ]        
      }    
    ]
}
POLICY
}
