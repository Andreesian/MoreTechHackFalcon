FROM python:3.10

ARG HUG_EMAIL=test
ARG HUG_PASSWORD=test

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN sed -i "s/HUG_EMAIL=.*/HUG_EMAIL=$HUG_EMAIL/" /app/config.ini
RUN sed -i "s/HUG_PASSWORD=.*/HUG_PASSWORD=$HUG_PASSWORD/" /app/config.ini

EXPOSE 5000

CMD ["python", "falcon.py"]