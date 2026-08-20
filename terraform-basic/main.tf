terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "test" {
  filename = "${path.module}/test.txt"
  content  = "Diese Datei wurde automatisch mit Terraform erstellt."
}