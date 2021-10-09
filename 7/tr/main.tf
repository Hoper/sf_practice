terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

provider "yandex" {
  token     = ""
  cloud_id  = ""
  folder_id = ""
  zone      = ""
}

# ++++++++++++++++++++ master noda   +++++++++++++++++++++++++

resource "yandex_compute_instance" "master-1" {
  name = "master-1"
  hostname = "master-1"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 10  # trotle CPU 10% low cost
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sn-B7.id
    nat       = true
  }

  metadata = {
    #    ssh-keys = "ubuntu:${file("~/.ssh/...")}"
    user-data = "${file("meta.txt")}"
  }
}

# ++++++++++++++++++++ worker noda-1   +++++++++++++++++++++++++

resource "yandex_compute_instance" "node-1" {
  name = "node-1"
  hostname = "node-1"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 10  # trotle CPU 10% low cost
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sn-B7.id
    nat       = true
  }

  metadata = {
    #    ssh-keys = "ubuntu:${file("~/.ssh/ya_rsa.pub")}"
    user-data = "${file("meta.txt")}"
  }
}

# ++++++++++++++++++++ worker noda-2   +++++++++++++++++++++++++

resource "yandex_compute_instance" "node-2" {
  name = "node-2"
  hostname = "node-2"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 10  # trotle CPU 10% low cost
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sn-B7.id
    nat       = true
  }

  metadata = {
    #    ssh-keys = "ubuntu:${file("~/.ssh/ya_rsa.pub")}"
    user-data = "${file("meta.txt")}"
  }
}

# ++++++++++++++++++++  NET +++++++++++++++++++++++++
resource "yandex_vpc_network" "vpc-B7" {
  name = "net-for-B7"
}

resource "yandex_vpc_subnet" "sn-B7" {
  name           = "subnet-for-B7"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc-B7.id
  v4_cidr_blocks = ["192.168.6.0/24"]
}

#================== RESULTS =======================
output "internal_ip_address_master-1" {
  value = yandex_compute_instance.master-1.network_interface.0.ip_address
}
output "internal_ip_address_node-1" {
  value = yandex_compute_instance.node-1.network_interface.0.ip_address
}
output "internal_ip_address_node-2" {
  value = yandex_compute_instance.node-2.network_interface.0.ip_address
}

output "external_ip_address_master-1" {
  value = yandex_compute_instance.master-1.network_interface.0.nat_ip_address
}

output "external_ip_address_node-1" {
  value = yandex_compute_instance.node-1.network_interface.0.nat_ip_address
}
output "external_ip_address_node-2" {
  value = yandex_compute_instance.node-2.network_interface.0.nat_ip_address
}