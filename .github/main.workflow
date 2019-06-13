workflow "Test & Release" {
  on = "push"
  resolves = ["npx semantic-release"]
}

action "npm ci" {
  uses = "docker://node:alpine"
  runs = "npm"
  args = "ci"
}

action "npm test" {
  needs = "npm ci"
  uses = "docker://node:alpine"
  runs = "npm"
  args = "test"
}

action "filter: master branch" {
  needs = "npm test"
  uses = "actions/bin/filter@master"
  args = "branch master"
}
action "mv pkg/* ." {
  needs = "filter: master branch"
  uses = "debian:stable-slim"
  runs = "mv"
  args = "pkg/* ."
}

action "npx semantic-release" {
  needs = "mv pkg/* ."
  uses = "docker://timbru31/node-alpine-git"
  runs = "npx"
  args = "semantic-release"
  secrets = ["GH_TOKEN", "NPM_TOKEN"]
}
