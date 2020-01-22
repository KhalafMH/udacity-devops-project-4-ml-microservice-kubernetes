FROM python:3.7.3-stretch

WORKDIR /app

COPY app.py requirements.txt ./
COPY model_data/ ./model_data/

# hadolint ignore=DL3013
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]
