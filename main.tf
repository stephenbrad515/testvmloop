# 1. Reserved Static IP Addresses
resource "google_compute_address" "static_ips" {
  count = 3
  name  = "debian-static-ip-${count.index}"
}

# 2. Additional Data Disks
resource "google_compute_disk" "data_disks" {
  count = 3
  name  = "debian-data-disk-${count.index}"
  type  = "pd-standard"
  size  = 20
}

# 3. VM Instances Loop
resource "google_compute_instance" "debian_nodes" {
  count        = 3
  name         = "debian-vm-${count.index}"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Attaching the secondary disk created above
  attached_disk {
    source      = google_compute_disk.data_disks[count.index].self_link
    device_name = "data-disk"
  }

  network_interface {
    network = "ubuntu-vpc"

    access_config {
      # Assigning the reserved static IP
      nat_ip = google_compute_address.static_ips[count.index].address
    }
  }

  # Ensures disks are attached correctly during creation
  lifecycle {
    ignore_changes = [attached_disk]
  }
}