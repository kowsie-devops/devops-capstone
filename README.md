# DevOps Capstone - End-to-End Pipeline


## Description
Simple Node.js app with CI/CD via Jenkins, Docker image pushed to Docker Hub and deployed to EC2. Monitoring via Prometheus & Grafana. Backup via cron script.


## Tech Stack
- Git / GitHub
- Jenkins
- Docker / Docker Hub
- AWS EC2 (Ubuntu)
- Prometheus, Node Exporter, Grafana
- Bash + Cron


## Setup (high level)
1. Clone repo.
2. Build image locally:
```bash
docker build -t youruser/capstone-node-app:latest .
docker push youruser/capstone-node-app:latest

Jenkins: add credentials, configure pipeline to use this repo.

App EC2: install Docker, ensure SSH key configured; create /home/ubuntu/deploy/deploy.sh.

Prometheus & Grafana: run on monitoring host; configure data source and dashboards.

CI/CD Flow (brief)

Push to GitHub -> Jenkins webhook triggers pipeline.

Jenkins builds, tests, dockerizes, pushes image to Docker Hub.

Jenkins SSHs to App EC2 and runs deploy script to pull new image and restart container.

Useful commands

docker logs -f capstone-app

docker ps

sudo systemctl status node_exporter

curl http://localhost:3000/health



---


## 10) `.gitignore`
Node

node_modules/ npm-debug.log

System

.bash_history .bash_logout .bashrc .profile .viminfo .sudo_as_admin_successful

SSH

.ssh/

Node exporter

node_exporter-/ node_exporter-.tar.gz

Editor temp

*.swp

---


## Notes
- Replace placeholders: `YOUR_DOCKERHUB_USERNAME`, `APP_EC2_IP`, and Jenkins credential IDs before use.
- Make `deploy/deploy.sh` and `backup/backup_logs.sh` executable: `chmod +x deploy/deploy.sh backup/backup_logs.sh`.
- For Jenkins credentials: create `dockerhub-creds` (username/password) and `ec2-ssh-key` (private key) to match the `Jenkinsfile`.


---


### How to use
1. Copy files into your repo root (preserve folders `deploy/` and `backup/` and `test/`).
2. Commit & push.
3. Follow earlier step-by-step to install Jenkins, add credentials, create pipeline, and run.


Good luck — tell me when you want me to generate a ready-to-download ZIP or create a `project_report.md`.
