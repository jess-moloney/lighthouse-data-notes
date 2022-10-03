# light-house-labs

# Lecture Notes
Things you've learned already:

EC2 and installing Jupyter Notebooks

## A Day in the Life of a Data Scientist

Dr. Sandy Shorts gets up, grabs a coffee, collects some data, prepares the data, uses a Jupyter Notebook to 
build a classifier model, and by noon wants to deploy that model for use by the rest of the world.

Today we will follow Sandy, looking over their shoulder, at the tools they're using to accomplish what 
they're doing that day.

## tmux

tmux is a fun tool that adds panes to your terminal, and makes managing groups of terminal panes easier. 
It's a bit of a 'power user' kind of tool, and so, we're going to learn the basics of it today, to become 
power users ourselves.

1) show how to add panes, split horizontally and vertically
2) sessions: convenient management of multiple terminals, run in the background (detach), can be named

Panes:
CTRL-B %          creates a new vertical pane to the right
CTRL-B "          creates a new horizontal pane below

Windows%:
CTRL-B c          creates a new window (which are numbered or named)
CTRL-B ,          renames a window

Sessions: (preserves which processes are running, in the background)
CTRL-B d                       detach from current session
>tmux attach -t 0              attach to named session
>tmux rename-session -t 0 git  renames 0 to git
>tmux new -s docker
>tmux kill-session -t docker

## APIs

Why? It's how we make resources (data and data structures) available to the technical public. We can allow 
others to send test data and get the predictions from our models.


## RESTFUL API Review

What is a REST API? (representational state transfer application programmer interface)


## Flask and Flask-Restful

Flask is a micro-framework to build web applications. Emphasis is on simplicity and flexibility.

Flask Restful API is a tool for creating APIs.


### show the program running locally

But where oh where will we deploy our Restful API programs publically?


## "The Cloud"

Three major core service providers:

AWS (Amazon built EC2 for themselves, but then offered as a complete product.)
Azure
Google Cloud

Data Science Platforms:

AWS: EC2 (compute resources), S3 (file storage), SageMaker (data science toolkit)
Azure: Azure Synapse Analytics
Google Cloud: https://cloud.google.com/data-science

Other:
Gradient

There is a whole job description in managing cloud instances.

<!-- "Pros and Cons"
=============== -->

## AWS

- basics
- demo
- install anaconda via an installer (paste the link from the website into your SSH terminal, wget on the cloud)
- OR use SageMaker which will set up notebooks for you
- there are setup/security/configuration settings to get right

AWS Steps:

Create an Account
Create a key pair (.pem for MacOSX or Linux, .ppk for WINDOWS)
Create Instance
Edit Security Group (next slide for specific protocols)
WINDOWS SPECIFIC: Install PUTTY (tutorial)(tutorial_video)
Start PUTTY
Category Pane - CLICK SESSION
Host Name = ec2-user@ec2-15-223-49-239.ca-central-1.compute.amazonaws.com
Connection Type = SSH
Port = 22
Category PANE - CLICK CONNECTION/SSH/AUTH
Browse to .ppk file
OPEN
Connect to Instance
https://www.anaconda.com/products/individual (Copy the linux download link to get the latest one)
Use wget method to download or curl
sh Anaconda3-2020.11-Linux-x86_64.sh (run this command to install)
Exit connection and re-enter connection.
jupyter lab --ip 0.0.0.0 --port 8888 --no-browser


# Setting Up

1. [Downloading Terraform](https://www.terraform.io/downloads)
1. [AWS CLI Download](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

1. Install TMUX
```bash
brew install tmux
```

1. Configure AWS CLI and add in acess key ID and secret key from [AWS Security Credential Manager](https://us-east-1.console.aws.amazon.com/iam/home#/security_credentials)
```bash
aws configure
```

### Building Infra
```bash 
terraform init
terraform plan
terraform apply

```



# References
1. https://github.com/pvarentsov/terraform-aws-free-tier
