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
    registry {
      use "docker" {
        # local registry
        image = "localhost:5000/example-nodejs"
        tag   = "1"
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
