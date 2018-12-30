workflow "Build and deploy container on push" {
  on = "push"
  resolves = ["GitHub Action for Docker-1", "GitHub Action for Docker"]
}

action "GitHub Action for Docker" {
  uses = "actions/docker/cli@76ff57a"
  args = "build . -t yaakovh/github-action-dotnet-test"
}

action "On master branch only" {
  uses = "actions/bin/filter@b2bea07"
  needs = ["GitHub Action for Docker"]
  args = "branch master"
}

action "Tag new container" {
  uses = "actions/docker/tag@76ff57a"
  needs = ["On master branch only"]
  args = "yaakovh/github-action-dotnet-test"
}

action "Log in to Docker Hub" {
  uses = "actions/docker/login@76ff57a"
  needs = ["Tag new container"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "GitHub Action for Docker-1" {
  uses = "actions/docker/cli@76ff57a"
  args = "push yaakovh/github-action-dotnet-test"
  needs = ["Log in to Docker Hub"]
}
