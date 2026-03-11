FROM debian:bullseye

RUN apt-get update && apt-get install -y python3 python3-pip && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt


EXPOSE 5000

CMD ["python3", "app.py"]