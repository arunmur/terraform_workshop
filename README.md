# terraform_workshop

This repo contains material to conduct a Terraform Workshop.

## Setup

We run all of our terraform commands though docker.

- Install [docker](https://docs.docker.com/engine/installation/#supported-platforms)
- Run `docker pull hashicorp/terraform` to download terraform


## Running commands

All terraform commands can be run through docker using

```
docker run --rm -ti -v "$PWD:/app" -w "/app" hashicorp/terraform
```

Try running the below command to get help,

```
docker run --rm -ti -v "$PWD:/app" -w "/app" hashicorp/terraform --help
```

Alternatively, to make your life in a shell easier you can alias the command to terraform

```
alias terraform='docker run --rm -ti -v $PWD:/app -w /app hashicorp/terraform'
```

You can set this alias in your profile file to automatically run everytime you log into a shell.

Now run,

```
terraform --help
```
