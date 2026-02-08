
# 1. Reserved Static IP Addresses
resource "google_compute_address" "xfce_static_ips" {
  count = 3
  name  = "debian-static-ip-${count.index}"
}

# 2. Additional Data Disks
resource "google_compute_disk" "xfce_data_disks" {
  count = 3
  name  = "debian-data-disk-${count.index}"
  type  = "pd-standard"
  size  = 20
}

# 3. VM Instances Loop
resource "google_compute_instance" "xfce_debian_nodes" {
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
    source      = google_compute_disk.xfce_data_disks[count.index].self_link
    device_name = "xfce_data-disk"
  }

  network_interface {
    network = "ubuntu-vpc"
    subnetwork = "private-subnet"

    #access_config {
      # Assigning the reserved static IP
     # nat_ip = google_compute_address.static_ips[count.index].address
    #}
  }

# Reference the external shell script
  metadata_startup_script = file("${path.module}/install_xfce.sh")


  # Ensures disks are attached correctly during creation
  lifecycle {
    ignore_changes = [attached_disk]
  }
}
