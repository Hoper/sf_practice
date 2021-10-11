#VARS for Yandex cloud AUTH
# need create env vars 
# $ export YC_FOLDER_ID=...
# YC_FOLDER_ID=
# YC_TOKEN=
# YC_ZONE=YC_ZONE
# YC_CLOUD_ID=
#

variable "ya_token" {
    description = "yandex token"
    type = string
    sensitive = true
    default = null  
}
variable "ya_cloud_id" {
    description = "yandex cloud_id "
    type = string
    sensitive = true
    default = null  
}
variable "ya_folder_id" {
    description = "yandex folder_id"
    type = string
    sensitive = true
    default = null  
}
variable "ya_zone" {
    description = "yandex zone"
    type = string
    sensitive = true
    default = null  
}