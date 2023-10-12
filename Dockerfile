FROM python:3.4-alpine

RUN apk add gcc g++ make libffi-dev openssl-dev git
RUN pip install pycryptodome
