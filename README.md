# Watcher for OpenShift Builds that use Git sources

It triggers a new build for a build config if it detects that the latest commit is not built.

## Usage

    git-build-watcher [-n <namespace>] buildconfigname
