project = "hello-world"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/catsby/waypoint-ecs"

    ref = "refs/heads/catsby"
  }

  # poll {
  #   enabled = true
  # }
}

app "web" {
  build {
    use "docker" {}

    registry {
      use "aws-ecr" {
        region = "us-west-2"

        #repository = "797645259670.dkr.ecr.us-west-2.amazonaws.com/cts-waypoint-server"
        repository = "cts-waypoint-server/thing"
        tag        = "latest"
      }
    }
  }

  deploy {
    use "aws-ecs" {
      region = "us-west-2"
      memory = 1024
    }
  }
}
