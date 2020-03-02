# This Dockerfile descended from https://github.com/mailchain/goreleaser-xcgo
# Much gratitude to the mailchain team for doing the hard work.
FROM neilotoole/golang-cross

# Ancestral Dockerfile maintainer was <robdefeo@gmail.com>
LABEL maintainer="neilotoole@apache.org"


ENV GORELEASER_VERSION=0.127.0
ENV GORELEASER_SHA=bf7e0f34d1d46041f302a0dd773a5c70ff7476c147d3a30659a5a11e823bccbd

ENV GORELEASER_DOWNLOAD_FILE=goreleaser_Linux_x86_64.tar.gz
ENV GORELEASER_DOWNLOAD_URL=https://github.com/goreleaser/goreleaser/releases/download/v${GORELEASER_VERSION}/${GORELEASER_DOWNLOAD_FILE}

RUN  wget ${GORELEASER_DOWNLOAD_URL}; \
			echo "$GORELEASER_SHA $GORELEASER_DOWNLOAD_FILE" | sha256sum -c - || exit 1; \
			tar -xzf $GORELEASER_DOWNLOAD_FILE -C /usr/bin/ goreleaser; \
			rm $GORELEASER_DOWNLOAD_FILE;

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \ 
 	add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && \
	apt-get install -y docker-ce \
	docker-ce-cli

ENTRYPOINT ["/entrypoint.sh"]
CMD ["-h"]

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
