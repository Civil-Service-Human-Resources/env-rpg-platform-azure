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

variable "environment__ENC_subscription_id" {
  type = "string"
  description = "the azure subscription ID where the enviromment sits"

} 
