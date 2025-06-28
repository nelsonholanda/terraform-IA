# S3 Bucket para hospedagem estática
resource "aws_s3_bucket" "static_website" {
  bucket = "tf-ia-${random_string.bucket_suffix.result}"
  
  tags = merge(var.default_tags, {
    Name = "tf-ia-static-website"
  })
}

# Random string para garantir nome único do bucket
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Configuração de hospedagem estática do S3
resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Política de bucket para acesso público
resource "aws_s3_bucket_policy" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      },
    ]
  })
}

# Configuração de ownership do bucket
resource "aws_s3_bucket_ownership_controls" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configuração de ACL pública
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Upload do arquivo HTML
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/index.html")
  
  tags = merge(var.default_tags, {
    Name = "tf-ia-index-html"
  })
}

# IAM Role para ECS Task acessar o S3
resource "aws_iam_role_policy" "ecs_task_s3_access" {
  name = "nh-ecs-task-s3-access"
  role = aws_iam_role.ecs_task.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Resource = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
} 