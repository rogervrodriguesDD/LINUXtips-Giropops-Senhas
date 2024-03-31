FROM python:3.10.14-slim as build

WORKDIR giropops-senhas
COPY . /giropops-senhas

ENV VIRTUAL_ENV=/giropops-senhas/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apt-get install pip -y \
  && python3 -m venv $VIRTUAL_ENV

RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.10.14-slim
WORKDIR giropops-senhas
ENV REDIS_HOST="gpops-redis-service"  
ENV VIRTUAL_ENV=/giropops-senhas/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY --from=build /giropops-senhas/ /giropops-senhas/

EXPOSE 80
ENTRYPOINT ["flask", "run"]
CMD ["--host", "0.0.0.0", "--port", "80"]
