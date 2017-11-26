# terraform_workshop

This repo contains material to conduct a Terraform Workshop.

## Setup

We run all of our terraform commands though docker.

- Install [docker](https://docs.docker.com/engine/installation/#supported-platforms)
- Install [aws cli](https://aws.amazon.com/cli/)
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

- [Create an AWS account](https://portal.aws.amazon.com/billing/signup) - Firefox will provide you with better experience :)
- [Sign in to AWS account](https://signin.aws.amazon.com/signin)
- Create an user to work with,
  - Services -> type IAM and click -> Users (from side menu) -> Click Add user.
  - Fill in name, ensure "Programmatic access" and "AWS Management Console access" are enabled.
  - Either set a password or enable "Require password reset"
  - Click (next and) Create Groups on the next page.
  - Give it a name (eg: Admins), and choose "Administrator Access" in the policies table below.
    - This will make that user and admin and give him all permissions.
  - **On the final screen click download csv**, this contains the user's AWS_ACCESS_KEY and AWS_SECRET_KEY
  - Also **copy the signin URL** for your account, this will provide a login page with your account id filled in.
  - From the CSV file, note the Access key ID and Secret access key
  - **If you are already using aws cli for another account** move `~/.aws/credentials` file to somewhere else
  - run `aws configure`
  - Logout of AWS account and login to the user account using the signin URL you copied earlier.

