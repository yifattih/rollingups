# Use an official Python runtime as a parent image
FROM python:3.13-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY src src

# Copy the python dependencies 
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 8000

# Define environment variable to ensure app runs in production mode
ENV FLASK_ENV=production

# Run app.py when the container launches
CMD ["python", "./src/main.py"]
