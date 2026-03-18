# 🚀 Proxmox Template Automation (Ansible)

## 📌 Overview

This project automates the creation of Ubuntu VM templates across Proxmox nodes using Ansible.

It works by:

1. Connecting to Proxmox nodes via SSH
2. Executing a shell script to:

   * Download Ubuntu cloud images
   * Create VMs
   * Configure cloud-init
   * Convert VMs into templates

---

## 🧰 Tech Stack

* Ansible
* Bash
* Proxmox VE
* Cloud Images (Ubuntu)

---

## 📂 Project Structure

```
proxmox-template-automation/
├── inventory/
│   └── hosts.ini
├── playbooks/
│   └── site.yml
├── roles/
│   ├── tasks/
│   ├── defaults/
│   ├── files/
│   └── ...
└── README.md
```

---

## ⚙️ How It Works

* Ansible copies `create_ubuntu.sh` to target nodes
* Script downloads Ubuntu image
* VM is created using `qm` commands
* Disk is imported and configured
* VM is converted into a reusable template

---

## 🔧 Configuration

### 1. Inventory

Edit:

```
inventory/hosts.ini
```

Example:

```
[proxmox_nodes]
50.117.8.194
50.117.40.202
```

---

### 2. Variables

Defined in:

```
roles/defaults/main.yml
```

Example:

```
ubuntu_templates:
  - vm_id: 9000
    codename: jammy
    template_name: ubuntu-22-template

  - vm_id: 9001
    codename: noble
    template_name: ubuntu-24-template
```

---

## 🚀 Usage

Run the playbook:

```
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

---

## 📜 Script Details

The script:

```
roles/files/create_ubuntu.sh
```

Performs:

* Image download from Ubuntu cloud
* VM creation (`qm create`)
* Disk import (`qm importdisk`)
* Cloud-init configuration
* Template conversion (`qm template`)

---

## ⚠️ Requirements

* Proxmox nodes accessible via SSH
* Root or sudo access
* `qm` command available (Proxmox installed)
* Internet access to download images

---

## 🔐 Security Notes

* SSH access should be key-based (use your ssh-bootstrap repo)
* Do not expose private keys
* Inventory should not contain sensitive data

---

## 🔗 Related Project

SSH bootstrap tool:

👉 https://github.com/d-Prashanth/ssh-bootstrap

---

## 🎯 Use Case

* Automate template creation across multiple Proxmox nodes
* Standardize VM images
* Prepare infrastructure for rapid VM deployment

---

## 👨‍💻 Author

Prashanth D

