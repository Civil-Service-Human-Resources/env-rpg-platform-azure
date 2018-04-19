#http://patorjk.com/software/taag/#p=display&f=Big&t=Enviornment
# ______            _                                       _
#|  ____|          (_)                                     | |
#| |__   _ ____   ___  ___  _ __ _ __  _ __ ___   ___ _ __ | |_
#|  __| | '_ \ \ / / |/ _ \| '__| '_ \| '_ ` _ \ / _ \ '_ \| __|
#| |____| | | \ V /| | (_) | |  | | | | | | | | |  __/ | | | |_
#|______|_| |_|\_/ |_|\___/|_|  |_| |_|_| |_| |_|\___|_| |_|\__|

variable "environment__name"        {
  description = "Name of the environment the resource is deployed to, e.g. Dev, Test, UAT, etc."
}

variable "environment__public_key_cshr"  {
  type = "string"
  description = "the ssh public key for jump key pair"
}

variable "environment__public_key_none"  {
  type = "string"
  description = "a public key with no associated private key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIQREt6U0dPe1SSo+F6mc3KHbbADXE/svkYGCx0ozWPnm6RJbdS4LWDVVwEhB4NwqnCnc+q9C1AmuWjKYCPaLFd5Ql7ZGX+g9wPcqgcsTEBWKtOLIsHG0mYgYqwN1pJM8U+26div3BR4cSYxMh89j/vrL8vO3ZFu11nYrOrymCqGEa0XxKLKMrALwN+XDbZ3jaWH7m0WPNuzW0Uv3mrCpz9FdrhfxCVBbnkjYHcq9FNvLLqgHUaA3+94HGIwAv/xCU12xo7dw3gmpWeFezISK404vAYzBV0OVjrOMwAvWXn9ywNX4V4QzLkn34pgUEui1lqaAxOOOFKTzA8P6PpzOR none@cshr"
}

variable "environment__cidr_second_oc" {
  type = "string"
  description = "second octet of environment CIDR"
}
