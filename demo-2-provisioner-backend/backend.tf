terraform {
    backend "s3" {
        bucket  = "terraform-tfstate-exilemirror"
        key     = "demo2/demo2.tfstate"
        region  = "ap-southeast-1"
    }
}