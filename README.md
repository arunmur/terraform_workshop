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


## Getting ready - Can be done in the workshop

To create an account follow instuctions [here](./aws_account_setup/README.md)

## Typical execution cycle

This is the typical execution cycle of an application managed by terraform

```


   +-----------+          +----------+
   | Plan      | -------> |  Apply   |
   +-----------+          +----------+
                            |     |
                            |     \------------\  +-----+
                            |                  |  |  *  |
                            V                  V  V     |
                      +-----------+           +--------------+              +---------------+
                      |  Create   | ------->  |   Upgrade    |  --------->  |  Destroy      |
                      +-----------+           +--------------+              +---------------+


```


`terraform plan` and `terraform apply` commands are used to mange the application infrastructure on the cloud.


### Useful commands

- Ssh into public instance `ssh -i ~/.ssh/[.pem file] ubuntu@[instance ip]`
- Scp a file into an instance `scp -i ~/.ssh/[.pem file] ./file(src) ubuntu@[instance ip]:/tmp/(dest)`
- Scp a file from an instance `scp -i ~/.ssh/[.pem file] ubuntu@[instance ip]:/tmp/(src) ./file(dest)`


## Useful links

- [iTerm2](https://www.iterm2.com/version3.html)
- [CIDR Wiki](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)
- [CIDR Calculator](http://networkcalculator.ca/cidr-calculator.php)
- [Packer](https://www.packer.io/)
