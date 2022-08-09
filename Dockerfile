FROM python:3
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="ExpansionHunter image for use in Workflows(https://github.com/Illumina/ExpansionHunter/)"

RUN apt-get update && apt-get install -y \
  wget

# install REViewer
ENV REVIEWER_VERSION=0.2.7

RUN wget https://github.com/Illumina/REViewer/releases/download/v${REVIEWER_VERSION}/REViewer-v${REVIEWER_VERSION}-linux_x86_64.gz \
  && gunzip REViewer-v${REVIEWER_VERSION}-linux_x86_64.gz \
  && mv REViewer-v${REVIEWER_VERSION}-linux_x86_64 /opt/REViewer \
  && chmod +x /opt/REViewer


# install Expansion Hunter
ENV EXPANSION_HUNTER_VERSION=5.0.0

WORKDIR /tmp
RUN wget https://github.com/Illumina/ExpansionHunter/releases/download/v${EXPANSION_HUNTER_VERSION}/ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && tar -zxvf ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && mv ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64/bin/ExpansionHunter /opt \
  && rm -rf /tmp

WORKDIR /
