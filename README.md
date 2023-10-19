# Docker Ubuntu Wrapper for DevOps Engineers

This container wraps common commands used by DevOps engineers working with purposeful technology and facilitates the decisive segmentation of client specific code and credentials.

## Available Commands / Software
| Command | Comment | Version |
|---------|---------|---------|
| `terraform` | Provides support for Terraform. Must be configured with your credentials for the relevant provider. | 1.6.1 |
| `aws` | AWS-CLI V2 Latest Version as at 17th October 2023 | 2.13.26 |
| `brew` | Homebrew, simple PostNIX package management system. | 4.1.16 |
| `curl` | cURL CLI | 7.81.0 |
| `wget` | Wget CLI | 1.21.2 |
| `unzip` | Provides support for expanding ZIP files. | 6.00 |
| `nano` | Popular PostNIX text editor. | 6.2 |
| `vi` | Slimlined basic PostNIX text editor. | Vi IMproved 8.2 |
| `stax2aws` | Provides SSO support for AWS-CLI | 1.4.3 |
| `az` | Azure CLI | 2.53.0 |
| `git` | GIT CLI | 2.43.1 |
| `python3` | Python CLI | 3.10.12 |
| `ansible` | Ansible | 2.15.5 |

## Get Started
Run the following commands;
1. `docker build -t wrap .` (Note: If running Apple Silicone, please use the command `docker build -t wrap -f ARMv8-Dockerfile .`)
1. `docker-compose up -d`
1. `docker exec -it wrap /bin/bash`

## Configuring Bash Aliases
Add the following to your *~/.bashrc* or *~/.zshrc* file to provide the `wrap` command. Alternatively, if you use [Foxables Open-ZSH](https://github.com/Foxables/Open-zshrc), you can add the below code to your `$ZSH/.zshrc.d/` folder as `.wrap.sh` and then run `source ~/.zshrc` on your host machine.

```sh
wrap () {
    if [ -z "$1" ]
    then
        echo "No argument was supplied. Please ensure that arguments are encased in quotations to prevent unescaped strings.";
        return
    fi

    if [ "$1" = "enter" ] || [ "$1" = "e" ]
    then
        echo "Entering interactive terminal on wrapper..."
        docker exec -it wrap /usr/bin/zsh
        return
    fi

    echo "Executing command on wrapper..."
    echo "$1 2>&1" | docker exec -i wrap /usr/bin/zsh -
}
```

Note: You can use `wrap e` or `wrap enter` to enter the Ubuntu Wrapper Context with an interactive terminal, this allows you to run any number of interactive commands directly within the Ubuntu container.

## Configuring Git
The basics of git are configured for you within the relevant `.env` file. However! You will need to generate your SSH Key and store it within the .ssh directory.
1. Run `wrap e` or `docker exec -it wrap /usr/bin/zsh`.
1. Run the command `ssh-keygen` and follow the prompts. Your SSH key should be created in the wrap container under the /root/.ssh directory which maps to the local .ssh directory on the docker host machine.
1. Add your newly generated public key to your git account on the relevant git server.

> In some cases you may need to run `ssh git@hostname` in order to add the host identifier to the ~/.ssh/known_hosts file.

Note: Custom changes to the container config that are not in the `Dockerbuild` file may be lost when executing `docker-compose down`.

## Additional Information
By default, this project is configured to connect to a dev-container called `wrap`. If you intend on using a different name, you may need to remove the `.devcontainer` configuration and follow the official documentation on [How to Configure VSCode to Run in an Existing Dev Container](https://code.visualstudio.com/docs/devcontainers/attach-container).

Note: Homebrew within a linux container does not support Apple Silicone natively. Containers that run on Apple Silicone will need to be ran using platform emulation. Please use the ARMv8-Dockerfile for all Apple Silicone Environments.

Warning: Do not commit your existing repositories to any fork of this project. The `repos` directory is added to the `.gitignore` file for a reason.