variable "google-images" {
    type = map(string)
    
    default = {
        "us-east1" = "ubuntu-1804-bionic-v20200701"
        "us-central1" = "ubuntu-1804-bionic-v20200701"
    }
}