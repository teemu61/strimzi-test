FROM uusirepo.fi/image/python:3.11-slim

COPY Pipfile Pipfile.lock /app/

WORKDIR /

RUN cd app && set -ex && PIP_IGNORE_INSTALLED=1 pipenv --pypi-mirror https://catana.saunalahti.fi/root/pypi/ install --system --deploy

COPY ./app/ /app/
COPY version.json /
COPY LICENCE /

ENTRYPOINT ["python", "-m", "app"]
