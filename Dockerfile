FROM python:3.8-slim-buster

# Update the package repository, install necessary packages, and clean up
RUN apt-get update && apt-get install -y \
    libyang-dev \
    wget \
    xsltproc \
    && rm -rf /var/lib/apt/lists/*

# Install pyang
RUN pip3 install --no-cache-dir pyang

# Install xpath plugin
RUN wget -O /usr/local/lib/python3.8/site-packages/pyang/plugins/xpath.py \
    https://raw.githubusercontent.com/NSO-developer/pyang-xpath/master/xpath.py
RUN apt-get --purge remove wget -y

# Create a user 'auser' and set ownership for /app directory
RUN useradd -m -s /bin/bash auser
RUN mkdir /app && chown -R auser:auser /app

# Set the working directory
WORKDIR /app

# Switch to the user 'auser'
USER auser

# Command to run when the container starts
CMD ["/bin/bash"]
