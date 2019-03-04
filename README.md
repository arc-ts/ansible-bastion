# Ansible Bastion

A dockerized SSH and SOCKS5 bastion for Ansible.

## Getting Started

These instructions will cover usage information and for the docker container 

### Prerequisities

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Examples

Import public keys from file.keys and use ports 22/2222.

```shell
docker run -d -p 22:22 -p 2222:2222 -e AUTHORIZED_KEYS_FILE=/file.keys -v /path/to/file.keys:/file.keys arcts/ansible-bastion
```

Import public keys from file.keys, use existing host keys, and random ports.

```shell
docker run -d -P -e AUTHORIZED_KEYS_FILE=/file.keys -v /path/to/file.keys:/file.keys -e HOST_KEYS_DIR=/host_keys -v /path/to/host_keys:/host_keys arcts/ansible-bastion
```

#### Environment Variables

* `AUTHORIZED_KEYS` - A string containing authorized keys
* `AUTHORIZED_KEYS_FILE` - Specifies a file containing authorized keys to import. You will also need to mount the file inside the container
* `HOST_KEYS_DIR` - Specifies a directory to import SSH host keys from. This will only import keys that start with ssh_host_
