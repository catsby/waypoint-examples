project = "go-remote-docker"

runner {
  enabled = true

  data_source "git" {
    # url  = "https://github.com/hashicorp/waypoint-examples.git"
    url  = "https://github.com/catsby/waypoint-examples.git"
    path = "docker/go-data-source"
    ref  = "go-remote-docker"
  }
}

app "example-go" {
  labels = {
    "service" = "example-go"
    "env"     = "dev"
  }

  build {
    use "pack" {}

    registry {
      use "docker" {
        image = "example.com/my-app"
        tag   = gitrefpretty()
        local = true
      }
    }
  }

  deploy {
    use "docker" {}
  }
}
