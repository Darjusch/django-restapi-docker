FROM python:3

RUN mkdir /goodbuy_docker
WORKDIR /goodbuy_docker

COPY requirements.txt /goodbuy_docker
RUN pip install --no-cache-dir -r requirements.txt

COPY . /goodbuy_docker
