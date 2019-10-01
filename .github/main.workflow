workflow "Check & Release" {
  on = "push"
  resolves = ["Create GitHub release"]
}

action "filter tag" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "tag"
}

action "Create GitHub release" {
  uses = "Roang-zero1/github-create-release-action@master"
  env = {
    VERSION_REGEX = "^v[[:digit:]]+\\.[[:digit:]]+\\.[[:digit:]]+",
    UPDATE_EXISTING = "y",
  }
  secrets = [
    "GITHUB_TOKEN"
  ]
  needs = ["filter tag"]
}
