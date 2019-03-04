#!/bin/ash
mkdir -p ~/.ssh/control
cat /dev/zero | ssh-keygen -t rsa -b 4096 -q -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
if [ -f /etc/ssh/ssh_host_rsa_key ]
then
    echo Host keys already present
else
    ssh-keygen -A
fi
if [ -n "$AUTHORIZED_KEYS" ]
then
    echo Adding keys from env
    echo $AUTHORIZED_KEYS >> ~/.ssh/authorized_keys
fi
if [ -e "$AUTHORIZED_KEYS_FILE" ] && [ -f "$AUTHORIZED_KEYS_FILE" ]
then
    echo Adding keys from file $AUTHORIZED_KEYS_FILE
    cat $AUTHORIZED_KEYS_FILE >> ~/.ssh/authorized_keys
fi
sleep 10
ssh -o "NoHostAuthenticationForLocalhost=yes" -o "ConnectTimeout=30" -o "ControlMaster=auto" -o "ControlPersist=no" -o "ControlPath=~/.ssh/control/ssh-%r@%h:%p" -CfN -D 0.0.0.0:2222 localhost &
exec /usr/sbin/sshd -D -e "$@"