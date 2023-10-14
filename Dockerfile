FROM python:3.7

ARG hug_email=default_value
ARG hug_password=default_value

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN sed -i "s|{{MY_VARIABLE}}|${MY_VARIABLE}|g" /app/config.ini

EXPOSE 5000

CMD ["python", "falcon.py"]