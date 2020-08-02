FROM thies88/base-ubuntu

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# variable for version
#ENV REPO-MEDIAAREA-VERSION="repo-mediaarea_1.0-12_all.deb"
ENV REL="bionic"

RUN \
 echo "**** install apt-transport-https ****" && \
 apt-get update && \
 apt-get install -y apt-transport-https gnupg2 && \
 echo "**** add mono repository ****" && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
 echo "deb http://download.mono-project.com/repo/ubuntu ${REL} main" | tee /etc/apt/sources.list.d/mono-official.list && \
 echo "**** add mediaarea repository ****" && \
 curl -L \
	"https://mediaarea.net/repo/deb/repo-mediaarea_1.0-12_all.deb" \
	-o /tmp/key.deb && \
 dpkg -i /tmp/key.deb && \
 echo "deb https://mediaarea.net/repo/deb/ubuntu bionic main" | tee /etc/apt/sources.list.d/mediaarea.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	bzip2 \
	ca-certificates-mono \
	libcurl4-openssl-dev \
	mediainfo \
	mono-devel \
	mono-vbnc \
	python \
	sqlite3 \
	unzip && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
