FROM python:3.10-alpine

RUN apk add gcc g++ make libffi-dev openssl-dev git
RUN pip install pycryptodome
