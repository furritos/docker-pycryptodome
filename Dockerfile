FROM python:3.5-alpine

RUN apk add gcc g++ make libffi-dev openssl-dev git
RUN pip install pycryptodome
