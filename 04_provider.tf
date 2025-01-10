provider "aws" {
 region = "eu-west-1"
 default_tags {
   tags = {
     "Environment": "Learning-Project"
     "Owner": "Mamadou"
     "Role": "Training"
   }
 }
}