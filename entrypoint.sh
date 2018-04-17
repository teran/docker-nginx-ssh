#!/usr/bin/env bash

set -euo pipefail

SSH_HOST_RSA_KEY=${SSH_HOST_RSA_KEY:-}
SSH_HOST_RSA_PUBLIC_KEY=${SSH_HOST_RSA_PUBLIC_KEY:-}

SSH_HOST_ECDSA_KEY=${SSH_HOST_ECDSA_KEY:-}
SSH_HOST_ECDSA_PUBLIC_KEY=${SSH_HOST_ECDSA_PUBLIC_KEY:-}

SSH_HOST_ED25519_KEY=${SSH_HOST_ED25519_KEY:-}
SSH_HOST_ED25519_PUBLIC_KEY=${SSH_HOST_ED25519_PUBLIC_KEY:-}

SSH_AUTHORIZED_KEY=${SSH_AUTHORIZED_KEY:-}

if [[ -n "${SSH_HOST_RSA_KEY}" ]]; then
  echo "${SSH_HOST_RSA_KEY}" >/etc/ssh/ssh_host_rsa_key
  chown root:root /etc/ssh/ssh_host_rsa_key
  chmod 0400 /etc/ssh/ssh_host_rsa_key
  unset SSH_HOST_RSA_KEY
else
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

if [[ -n "${SSH_HOST_RSA_PUBLIC_KEY}" ]]; then
  echo "${SSH_HOST_RSA_PUBLIC_KEY}" >/etc/ssh/ssh_host_rsa_key.pub
  chown root:root /etc/ssh/ssh_host_rsa_key.pub
  chmod 0400 /etc/ssh/ssh_host_rsa_key.pub
  unset SSH_HOST_RSA_PUBLIC_KEY
fi

if [[ -n "${SSH_HOST_ECDSA_KEY}" ]]; then
  echo "${SSH_HOST_ECDSA_KEY}" >/etc/ssh/ssh_host_ecdsa_key
  chown root:root /etc/ssh/ssh_host_ecdsa_key
  chmod 0400 /etc/ssh/ssh_host_ecdsa_key
  unset SSH_HOST_ECDSA_KEY
else
  ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
fi

if [[ -n "${SSH_HOST_ECDSA_PUBLIC_KEY}" ]]; then
  echo "${SSH_HOST_ECDSA_PUBLIC_KEY}" >/etc/ssh/ssh_host_ecdsa_key.pub
  chown root:root /etc/ssh/ssh_host_ecdsa_key.pub
  chmod 0400 /etc/ssh/ssh_host_ecdsa_key.pub
  unset SSH_HOST_ECDSA_PUBLIC_KEY
fi

if [[ -n "${SSH_HOST_ED25519_KEY}" ]]; then
  echo "${SSH_HOST_ED25519_KEY}" >/etc/ssh/ssh_host_ed25519_key
  chown root:root /etc/ssh/ssh_host_ed25519_key
  chmod 0400 /etc/ssh/ssh_host_ed25519_key
  unset SSH_HOST_ED25519_KEY
else
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi

if [[ -n "${SSH_HOST_ED25519_PUBLIC_KEY}" ]]; then
  echo "${SSH_HOST_ED25519_PUBLIC_KEY}" >/etc/ssh/ssh_host_ed25519_key.pub
  chown root:root /etc/ssh/ssh_host_ed25519_key.pub
  chmod 0400 /etc/ssh/ssh_host_ed25519_key.pub
  unset SSH_HOST_ED25519_PUBLIC_KEY
fi

if [[ -n "${SSH_AUTHORIZED_KEY}" ]]; then
  echo "${SSH_AUTHORIZED_KEY}" >/home/publisher/.ssh/authorized_keys
  chown -R publisher:publisher /home/publisher/.ssh
  chmod 0400 /home/publisher/.ssh/authorized_keys
  unset SSH_AUTHORIZED_KEY
fi

exec supervisord -n -c /etc/supervisor/supervisord.conf
