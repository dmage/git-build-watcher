# Watcher for OpenShift Builds that use Git sources

`git-build-watcher` is a one-shot tool that initiates a new build for a
BuildConfig when it detects that the latest Git commitish it not built.

It is useful in situations in which setting up a webhook is not feasible.

## Usage

    git-build-watcher [-n <namespace>] <buildconfig>

## How it works?

It gets the Git repository URL and the Git reference name from the build
config's `.spec.source.git`.

Then it calls `git ls-remote` to get the current commitish for the Git
reference and checks if the latest build has the same commitish in
`.spec.revision.git.commit`.

If the build is not found or uses a different commit, this tool triggers a new
build.

## How to use it?

This repository contains manifests for a CronJob that runs `git-build-watcher`
every 5 minutes. You can create it for the BuildConfig `MY-BUILDCONFIG` in the
namespace `MY-NAMESPACE` using these commands:

```console
$ git clone https://github.com/dmage/git-build-watcher.git
$ cd ./git-build-watcher
$ mkdir ./my-deployment && cat >./my-deployment/kustomization.yaml <<END
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: MY-NAMESPACE
bases:
- ./../manifests
configMapGenerator:
- name: git-build-watcher
  literals:
  - buildconfig=MY-BUILDCONFIG
END
$ kubectl apply -k ./my-deployment/
```
