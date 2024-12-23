# Create s3 bucket
resource "aws_s3_bucket" "viviresumebucket1" {
    bucket = var.bucketname
}

# Set the bucket ownership, so evrything inside the bucket is owned by the owner
resource "aws_s3_bucket_ownership_controls" "bucket_owner" {
    bucket = aws_s3_bucket.viviresumebucket1.id  

    rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Make the bucket to publicly accessible
resource "aws_s3_bucket_public_access_block" "allow_public_access" {
    bucket = aws_s3_bucket.viviresumebucket1.id 

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

# Create Bucket policy to allow public access to the bucket objects
resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.viviresumebucket1.id 

    policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "allow public access to the bucket objects",
			"Principal": "*",
			"Effect": "Allow",
			"Action": [
				"s3:*"
			],
			"Resource": [
				"${aws_s3_bucket.viviresumebucket1.arn}",
                "${aws_s3_bucket.viviresumebucket1.arn}/*"
			]
		}
	]
})
depends_on = [ aws_s3_bucket_public_access_block.allow_public_access ] #Use this meta argument to ensure that the public access settings are applied before creating the bucket policy
}

# Upload index object
resource "aws_s3_object" "index" {
    bucket = aws_s3_bucket.viviresumebucket1.id  
    key = "index.html"
    source = "index.html"
    content_type = "text/html"
  
}

# Upload error object
resource "aws_s3_object" "error" {
    bucket = aws_s3_bucket.viviresumebucket1.id  
    key = "error.html"
    source = "error.html"
    content_type = "text/html"
  
}

# Upload Profile picture object
resource "aws_s3_object" "profile" {
    bucket = aws_s3_bucket.viviresumebucket1.id 
    key = "profile.png"
    source = "profile.png"

}

# enable static webiste hosting
resource "aws_s3_bucket_website_configuration" "enable_static_website" {
    bucket = aws_s3_bucket.viviresumebucket1.id 

    index_document {
    suffix = "index.html"
    }

    error_document {
    key = "error.html"
    }

    depends_on = [ aws_s3_object.index, aws_s3_object.profile ]
}