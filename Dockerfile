## Run unit tests

FROM hbpmip/python-base-build:0.0.0

COPY requirements-dev.txt /requirements-dev.txt
RUN pip install -r /requirements-dev.txt

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY main.py /src/main.py
COPY tests/unit/ /src/tests/

WORKDIR /src
RUN python -m pytest tests/ -x --ff --capture=no


## Build target image

FROM hbpmip/python-mip:0.6.8

MAINTAINER mirco.nasuti@chuv.ch

ENV DOCKER_IMAGE=hbpmip/my-algorithm:0.0.0 \
    FUNCTION=my-algorithm

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

COPY main.py /main.py

ENTRYPOINT ["python", "/main.py"]

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="hbpmip/my-algorithm" \
      org.label-schema.description="Python implementation of my-algorithm" \
      org.label-schema.url="https://github.com/LREN-CHUV/algorithm-repository" \
      org.label-schema.vcs-type="git" \
      org.label-schema.vcs-url="https://github.com/LREN-CHUV/algorithm-repository.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version="$VERSION" \
      org.label-schema.vendor="LREN CHUV" \
      org.label-schema.license="AGPLv3" \
      org.label-schema.docker.dockerfile="Dockerfile" \
      org.label-schema.schema-version="1.0"
