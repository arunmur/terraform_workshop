# Setting up your AWS Account

- [Create an AWS account](https://portal.aws.amazon.com/billing/signup) - Firefox will provide you with better experience :)
- [Sign in to AWS account](https://signin.aws.amazon.com/signin)
- Create a User for terraform to work with,

  **Type IAM in the services bar and click on it.**
  ![Search IAM](./SearchIAM.png)

  **Select Users in the left panel of IAM**

  ![Select Users](./SelectUsers.png)

  **Click on Add User**
  ![Add User](./AddUser.png)

  **Give the User a name and enable programatic access**
  ![User Perms](./UserPerms.png)

  **Click Next and on the Next screen Click on Create Group**
  ![Create Group](./CreateGroup.png)

  **Give the Group a name and allow Administrator Access**
  ![Group Name and Perms](./GroupNameAndPerms.png)

- Click on Review and Create User

  **On the last page download the CSV**
  ![Download CSV](./DownloadCSV.png)


- Create a Keypair

  **Open Services and select EC2**
  ![Select EC2](./SelectEC2.png)

  **Scroll down to Network Security and select Key Pairs**
  ![Select Key Pairs](./KeyPairs.png)

  **Create a Keypair, give it a name and download the pem certificate file**
  ![Download Pem](./DownloadPEM.png)

- Move the `.pem` file to `~/.ssh`, and reduce its permissions to 0600 using `chmod 0600 ~/.ssh/[pemfile]`
