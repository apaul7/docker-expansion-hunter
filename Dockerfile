FROM python:3
MAINTAINER Alexander Paul <alex.paul@.wustl.edu>

LABEL \
  description="ExpansionHunter image for use in Workflows(https://github.com/Illumina/ExpansionHunter/)"

RUN apt-get update && apt-get install -y \
  unzip \
  wget

# install GrapAlignmentViewer (use commit for version control)
ENV GRAPH_ALIGNMENT_VIEWER_COMMIT=b4805e544f503342890d9fdc6388502ac4b4b1e8

RUN pip3 install Matplotlib Numpy Pysam PyYAML
RUN wget https://github.com/Illumina/GraphAlignmentViewer/archive/${GRAPH_ALIGNMENT_VIEWER_COMMIT}.zip \
  && unzip ${GRAPH_ALIGNMENT_VIEWER_COMMIT}.zip \
  && mv GraphAlignmentViewer-${GRAPH_ALIGNMENT_VIEWER_COMMIT} GraphAlignmentViewer \
  && rm ${GRAPH_ALIGNMENT_VIEWER_COMMIT}.zip

# install Expansion Hunter
ENV EXPANSION_HUNTER_VERSION=5.0.0

WORKDIR /tmp
RUN wget https://github.com/Illumina/ExpansionHunter/releases/download/v${EXPANSION_HUNTER_VERSION}/ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && tar -zxvf ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64.tar.gz \
  && mv ExpansionHunter-v${EXPANSION_HUNTER_VERSION}-linux_x86_64/bin/ExpansionHunter /opt \
  && rm -rf /tmp

WORKDIR /
