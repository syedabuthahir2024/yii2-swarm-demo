# 🚀 Yii2 Docker Swarm Deployment on AWS EC2

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/YOUR_USERNAME/YOUR_REPO/deploy.yml?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/YOUR_DOCKERHUB_USERNAME/yii2-app?style=flat-square)
![License](https://img.shields.io/github/license/YOUR_USERNAME/YOUR_REPO?style=flat-square)

Deploy your **Yii2 PHP application** with confidence using **Docker Swarm** on **AWS EC2**, backed by a fully automated **CI/CD pipeline** and **infrastructure-as-code** with Ansible.

---

## ✨ Features

- 🐳 **Dockerized Yii2 Application** — containerized for portability & consistency  
- ⚙️ **Docker Swarm Orchestration** — simple cluster management & scaling  
- 🔥 **NGINX Reverse Proxy** — host-level traffic routing for reliability  
- 🤖 **CI/CD via GitHub Actions** — seamless build, test & deploy automation  
- 🛠️ **Infrastructure Automation with Ansible** — repeatable & version-controlled setup  
- 📊 **(Optional) Monitoring** — integrate **Prometheus** & **Node Exporter** for insights  

---

## 🛠️ Prerequisites

| Requirement          | Description                            |
|----------------------|------------------------------------|
| AWS Account          | To launch and manage EC2 instances  |
| GitHub Account       | For repo hosting and Actions CI/CD  |
| Docker Hub Account   | Host container images                |
| SSH Key Pair         | Secure access to your EC2 instance  |

---

## ⚡ Quick Setup & Deployment

### 1️⃣ Launch AWS EC2 Instance (Ubuntu 22.04)

- Open ports:  
  - SSH: `22`  
  - HTTP: `80`  
  - HTTPS: `443`  
  - Node Exporter (optional): `9100`  

### 2️⃣ Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
3️⃣ Configure Ansible
Edit ansible/inventory.ini → Add your EC2 public IP

Edit ansible/ansible.cfg → Set SSH private key path
4️⃣ Add GitHub Secrets
Set the following in your GitHub repository’s Secrets:

| Secret Name           | Description                    |
| --------------------- | ------------------------------ |
| `DOCKER_HUB_USERNAME` | Your Docker Hub username       |
| `DOCKER_HUB_TOKEN`    | Docker Hub access token        |
| `SSH_PRIVATE_KEY`     | Your EC2 SSH private key       |
| `KNOWN_HOSTS`         | SSH known\_hosts entry for EC2 |

5️⃣ Run Ansible Playbook for Initial Setup
bash
Copy
Edit
cd ansible
ansible-playbook -i inventory.ini playbook.yml

6️⃣ Push to GitHub to Trigger CI/CD
git push origin main

🌍 Access Your Application
| Service          | URL                                 |
| ---------------- | ----------------------------------- |
| Yii2 Application | `http://<EC2_PUBLIC_IP>`            |
| Prometheus (opt) | `http://<EC2_PUBLIC_IP>/prometheus` |

✅ Verification & Troubleshooting
Check Docker Services:
docker service ls
docker service ps yii2-app

View NGINX Logs:
sudo tail -f /var/log/nginx/yii2-app-*.log

(Optional) Verify Monitoring:
curl http://localhost:9100/metrics

View Prometheus Targets:
Visit: http://<EC2_PUBLIC_IP>/prometheus/targets

🔄 Rollback Deployment
If issues arise:
ssh ubuntu@<EC2_PUBLIC_IP>

docker service ps yii2-app

docker service update --rollback yii2-app


📌 Assumptions & Notes
EC2 instance runs Ubuntu 22.04

Container images stored on Docker Hub

Single-node Docker Swarm cluster for simplicity

NGINX runs directly on the host OS (not containerized)

🎉 Conclusion
This project delivers a fully automated, production-grade deployment pipeline for your Yii2 application, combining:

Modern container orchestration with Docker Swarm

Reliable NGINX reverse proxy for efficient traffic routing

Powerful CI/CD automation using GitHub Actions

Infrastructure as Code via Ansible for easy environment provisioning

Optional, integrated monitoring with Prometheus ecosystem

Deploy confidently and scale easily — your Yii2 app is ready for the cloud!

📫 Get in Touch
Need help? Feel free to open an issue or contact me via GitHub.

