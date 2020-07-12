variable "google-images" {
    type = map(string)
    
    default = {
        "us-east1" = "ubuntu-1804-bionic-v20200701"
        "us-central1" = "ubuntu-1804-bionic-v20200701"
    }
}

variable "cdirs_acesso_remoto" {
    type = list(string)
    default = ["187.57.0.19/32","201.82.235.169/32"]
}
variable "ips_acesso_remoto" {
    type = list(string)
    default = ["187.57.0.19","201.82.235.169"]
}