project = "hello-world"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/catsby/waypoint-examples"

    ref  = "refs/heads/go-remote-docker"
    path = "go-dockerfile-remote"
  }
}

app "web" {
  build {
    #use "pack" {}
    use "docker" {}

    # registry {
    #   use "docker" {
    #     image = "go-remote-docker"
    #     tag   = "1"
    #     local = true
    #   }
    # }

    registry {
      #use "aws-ecr" {  #  region = "us-west-2"

      #  #repository = "797645259670.dkr.ecr.us-west-2.amazonaws.com/cts-waypoint-server"
      #  repository = "cts-go/go-remote-docker"
      #  tag        = "latest"
      #}
      use "docker" {
        # region = "us-west-2"

        image = "797645259670.dkr.ecr.us-west-2.amazonaws.com/cts-hello"

        tag = "latest"
      }
    }
  }

  deploy {
    use "docker" {}
  }

  # deploy {
  #   use "kubernetes" {
  #     probe_path = "/"
  #   }
  # }

  # release {
  #   use "kubernetes" {
  #     // Sets up a load balancer to access released application
  #     load_balancer = true
  #     port          = 3000
  #   }
  # }
}
