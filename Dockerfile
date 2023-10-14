FROM python:3.7

ARG hug_email=default_value
ARG hug_password=default_value

# Set working directory to /app
WORKDIR /app

# Copy requirements.txt and run pip install -r requirements.txt
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy files to app directory
COPY . .

RUN sed -i "s|{{MY_VARIABLE}}|${MY_VARIABLE}|g" /app/config.ini

# Expose port 5000
EXPOSE 5000

# Start server with command "python main.py"
CMD ["python", "falcon.py"]