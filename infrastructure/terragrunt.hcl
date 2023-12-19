remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "lightfoot-tf-state-eks"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tf-state-table-lock-eks"
  }
}
// remote_state {
//   backend = "local"
//   generate = {
//     path      = "state.tf"
//     if_exists = "overwrite_terragrunt"
//   }

//   config = {
//     path = "${path_relative_to_include()}/terraform.tfstate"
//   }
// }

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region  = "eu-west-1"
}
EOF
}