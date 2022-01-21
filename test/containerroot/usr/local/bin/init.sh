#!/bin/bash -e

echo "${SSH_KEY}" >/etc/ssh/authorized_keys

exec /usr/sbin/sshd -D