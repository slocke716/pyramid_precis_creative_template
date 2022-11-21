ARG PYTHON_BASE

FROM docker.artifactory.aws.gel.ac/python:${PYTHON_BASE} as base
ARG PYPI_URL

RUN mkdir /pyramid_precis_creative_template
WORKDIR /pyramid_precis_creative_template

# copy build files
COPY pyproject.toml poetry.lock README.rst /pyramid_precis_creative_template/
COPY pyramid_precis_creative_template /pyramid_precis_creative_template/pyramid_precis_creative_template

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_CREATE=0 \
    PIP_INDEX_URL=$PYPI_URL

RUN sed -i 's|http://|https://artifactory.aws.gel.ac/artifactory/apt_|g' /etc/apt/sources.list

# libcurl4-gnutls-dev is necessary for Pysam. See PCA-179
RUN apt-get update -qq && apt-get install -qqy -f \
    build-essential \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libpq-dev \
    libsasl2-dev \
    libyaml-dev \
    libcurl4-gnutls-dev \
    nano \
    zlib1g-dev \
    && pip install -Iv --prefer-binary --index-url $PYPI_URL --upgrade \
    pip \
    poetry==1.1.7 \
    poetry-core==1.0.4

RUN poetry install --no-dev

FROM base as test
ARG PYPI_URL

WORKDIR /pyramid_precis_creative_template
COPY tests /pyramid_precis_creative_template/tests

# required to make sure pytest runs the right coverage checks
ENV PYTHONPATH .

# Must reinstall certain packages after poetry install --no-dev See: https://github.com/python-poetry/poetry/issues/4463
RUN pip install -Iv --prefer-binary --index-url $PYPI_URL --upgrade \
    pip \
    tomlkit \
    virtualenv \
    requests \
    && poetry install
