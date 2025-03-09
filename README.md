# Continuous Delivery: FastAPI with GitHub Actions & Docker

This project demonstrates **Continuous Delivery (CD)** by automating the creation and deployment of a **Dockerized FastAPI application** using **GitHub Actions** and **Docker Hub**.

---
## **1. Project Structure**
```
FastAPI-CD/
│── .github/workflows/DockerBuild.yml    # GitHub Actions workflow
│── main.py                               # FastAPI server
│── requirements.txt                      # Dependencies
│── Dockerfile                            # Containerization setup
│── README.md                             # Project documentation
```

---
## **2. How to Install & Run Locally**
### **Step 1: Clone the Repository**
```sh
git clone https://github.com/<your-username>/FastAPI-CD.git
cd FastAPI-CD
```

### **Step 2: Create a Virtual Environment**
```sh
python -m venv venv
source venv/bin/activate  # On Windows use `venv\Scripts\activate`
```

### **Step 3: Install Dependencies**
```sh
pip install -r requirements.txt
```

### **Step 4: Run the FastAPI Server**
```sh
uvicorn main:app --reload
```

### **Step 5: Test API in Browser or cURL**
- Open **http://127.0.0.1:8000** in your browser
- Or test using cURL:
```sh
curl -X 'GET' 'http://127.0.0.1:8000/' -H 'accept: application/json'
```

---
## **3. Docker Containerization**
### **Step 1: Build Docker Image Locally**
```sh
docker build -t <your-dockerhub-username>/fastapi-app:latest .
```

### **Step 2: Run Docker Container Locally**
```sh
docker run -p 8000:8000 <your-dockerhub-username>/fastapi-app:latest
```

### **Step 3: Test API in Browser or cURL**
- Open **http://127.0.0.1:8000** in your browser
- Or use cURL:
```sh
curl -X 'GET' 'http://127.0.0.1:8000/' -H 'accept: application/json'
```

---
## **4. Continuous Delivery with GitHub Actions**

### **Step 1: Generate a Docker Token**
1. Log in to **[Docker Hub](https://hub.docker.com/)**.
2. Go to **Account Settings > Security > Access Tokens**.
3. Click **Generate Token** and copy it.

### **Step 2: Set GitHub Actions Secrets**
1. Go to your repository on GitHub.
2. Navigate to **Settings > Secrets and variables > Actions**.
3. Click **New repository secret**.
4. Add the following:
   - **Name**: `DOCKERTOKEN`
   - **Value**: *Paste your Docker token*
5. Save and close.

### **Step 3: GitHub Actions Workflow (DockerBuild.yml)**
File Path: `.github/workflows/DockerBuild.yml`

```yaml
name: Docker Image Build & Push

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v1

      - name: Log in to Docker Hub
        run: echo "${{ secrets.DOCKERTOKEN }}" | docker login -u "<your-dockerhub-username>" --password-stdin

      - name: Build and Push Docker Image
        run: |
          docker build -t <your-dockerhub-username>/fastapi-app:latest .
          docker push <your-dockerhub-username>/fastapi-app:latest
```

### **Step 4: Verify Image Deployment in Docker Hub**
- Log in to **Docker Hub**
- Navigate to **Repositories**
- Check if `fastapi-app:latest` appears

---
## **5. Deployment from Docker Hub**
### **Run the Deployed Docker Image**
After GitHub Actions pushes the image to Docker Hub, you can pull and run it on any server:
```sh
docker pull <your-dockerhub-username>/fastapi-app:latest
docker run -p 8000:8000 <your-dockerhub-username>/fastapi-app:latest
```

---
## **6. Troubleshooting & FAQs**
### **Q1: GitHub Actions Fails on 'docker login' Step?**
✔ Ensure **DOCKERTOKEN** is set correctly under GitHub **Secrets**.
✔ Use a **Docker Access Token**, not your password.
✔ Verify your **Docker Hub username** is correct.

### **Q2: No Tags Visible in Docker Hub?**
✔ Run `docker images` to check if the image is tagged properly.
✔ Manually tag and push:
```sh
docker tag <IMAGE_ID> <your-dockerhub-username>/fastapi-app:latest
docker push <your-dockerhub-username>/fastapi-app:latest
```

### **Q3: Port 8000 Already in Use?**
✔ Kill existing process:
```sh
sudo lsof -i :8000
kill -9 <PID>
```
✔ Run the container on a different port:
```sh
docker run -p 8080:8000 <your-dockerhub-username>/fastapi-app:latest
```

---
## **7. Submission Format**
### **GitHub Repository URL**
🔗 [GitHub Repo](https://github.com/<your-username>/FastAPI-CD)

### **Docker Hub Image URL**
🔗 [Docker Hub](https://hub.docker.com/r/<your-dockerhub-username>/fastapi-app)

---
## **8. Summary**
✅ Created and containerized a **FastAPI server**
✅ Built and pushed **Docker images** to **Docker Hub**
✅ Automated **Continuous Delivery (CD)** with **GitHub Actions**
✅ Enabled easy deployment using **Docker Hub**

📢 **Next Steps:**
- Implement Kubernetes for **orchestration** 🚀
- Use AWS ECS/Fargate for **serverless deployment** ☁️

---
🎯 **Contributors:** <Your Name>


