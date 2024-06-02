# Use the official Python base image from the Docker Hub
FROM python:3.8-slim-buster

# Create a user 'auser' and set up the necessary directories
RUN useradd -m -s /bin/bash auser \
    && mkdir /app \
    && chown -R auser:auser /app

# Set the working directory
WORKDIR /app

# Update the package repository, install necessary packages, and clean up in a single RUN command
RUN apt-get update && apt-get install -y \
    libyang-dev \
    wget \
    xsltproc \
    yang-tools \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir pyang pyyaml \
    && wget -O /usr/local/lib/python3.8/site-packages/pyang/plugins/xpath.py \
    https://raw.githubusercontent.com/NSO-developer/pyang-xpath/master/xpath.py \
    && apt-get --purge remove wget -y

# Copy the scripts into the working directory and make them executable
COPY ["scripts/jy-converter.py", "scripts/xpath.py", "/usr/local/bin/"]
RUN chmod 755 /usr/local/bin/xpath.py && chmod 755 /usr/local/bin/jy-converter.py \
    && ln -s /usr/local/bin/xpath.py /usr/local/bin/xpath \
    && ln -s /usr/local/bin/jy-converter.py /usr/local/bin/jy-converter

# Switch to the non-root user
USER auser

# Command to run when the container starts
CMD ["/bin/bash"]

