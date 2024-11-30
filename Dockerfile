FROM python:3.9-slim

WORKDIR /app
COPY main.py requirements.txt /app/
RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["python3", "main.py"]
