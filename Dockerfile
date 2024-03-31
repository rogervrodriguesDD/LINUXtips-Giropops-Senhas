FROM python:3.10.14-slim

WORKDIR giropops-senhas
ADD . /giropops-senhas

ENV REDIS_HOST="gpops-redis-service"  
EXPOSE 80

RUN apt-get update \
  && apt-get install pip -y \
  && pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["flask", "run"]
CMD ["--host", "0.0.0.0", "--port", "80"]
