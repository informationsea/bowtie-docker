FROM debian:11-slim as extract
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /bowtie
ARG BOWTIE_VERSION=1.3.1
COPY bowtie-${BOWTIE_VERSION}-linux-x86_64.zip /bowtie
RUN unzip bowtie-${BOWTIE_VERSION}-linux-x86_64.zip

FROM debian:11-slim
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y unzip python3 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
ARG BOWTIE_VERSION=1.3.1
COPY --from=extract /bowtie /bowtie
ENV PATH=${PATH}:/bowtie/bowtie-${BOWTIE_VERSION}-linux-x86_64
