project = "hello-world"

runner {
  enabled = true

  data_source "git" {
    url = "https://github.com/catsby/waypoint-examples"

    ref  = "refs/heads/go-remote-docker"
    path = "go-dockerfile-remote"
  }

  # poll {
  #   enabled = true
  # }
}

app "web" {
  build {
    #use "pack" {}
    use "docker" {}

    registry {
      use "docker" {
        image = "go-remote-docker"
        tag   = "1"
        local = true
      }
    }
  }

  deploy {
    use "kubernetes" {
      probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
      // Sets up a load balancer to access released application
      load_balancer = true
      port          = 3000
    }
  }
}
