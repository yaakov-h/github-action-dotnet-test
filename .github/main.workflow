workflow "Build and deploy container on push" {
  on = "push"
  resolves = [
    "Build new container",
    "Deploy new container",
  ]
}

action "Build new container" {
  uses = "actions/docker/cli@76ff57a"
  args = "build . -t github-action-dotnet-test"
}

action "On master branch only" {
  uses = "actions/bin/filter@b2bea07"
  args = "branch master"
  needs = ["Build new container"]
}

action "Tag new container" {
  uses = "actions/docker/tag@76ff57a"
  needs = ["On master branch only"]
  args = "github-action-dotnet-test yaakovh/github-action-dotnet-test"
}

action "Log in to Docker Hub" {
  uses = "actions/docker/login@76ff57a"
  needs = ["Tag new container"]
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Deploy new container" {
  uses = "actions/docker/cli@76ff57a"
  args = "push yaakovh/github-action-dotnet-test"
  needs = ["Log in to Docker Hub"]
}
