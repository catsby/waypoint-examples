project = "example-nodejs"

runner {
  enabled = true

  data_source "git" {
    url  = "https://github.com/catsby/waypoint-examples.git"
    path = "kubernetes/nodejs"

    ref = "refs/heads/catsby-us-west-2"
  }
}

variable "repcount" {
  type    = number
  default = 1
}

app "example-nodejs" {
  labels = {
    "service" = "example-nodejs",
    "env"     = "dev"
  }

  build {
    use "pack" {}
    # registry {
    #   use "aws-ecr" {
    #     region     = "us-west-2"
    #     repository = "example-nodejs-repcount"
    #     tag        = "latest"
    #   }
    # }
    registry {
      use "docker" {
        # local registry
        # image = "192.168.147.4:5000/example-nodejs"
        image = "clint-C02C60MUMD6R.local:5000/example-nodejs"
        tag   = "1"
        # username = var.registry_username
        # password = var.registry_password
        local = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
      replicas = var.repcount
    }
  }

  release {
    use "kubernetes" {
    }
  }
}
