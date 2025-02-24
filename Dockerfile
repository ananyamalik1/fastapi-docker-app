# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install necessary system dependencies
RUN apt update && apt install -y python3 python3-pip python3-venv

# Create a virtual environment
RUN python3 -m venv /app/venv

# Activate the virtual environment and install dependencies
COPY requirements.txt .
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . .

# Set the default command using the virtual environment's Python
CMD ["/app/venv/bin/python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

