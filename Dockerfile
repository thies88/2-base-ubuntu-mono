FROM thies88/base-ubuntu

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install apt-transport-https ****" && \
 apt-get update && \
 apt-get install -y apt-transport-https gnupg2 && \
 echo "**** add mono repository ****" && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
 echo "deb http://download.mono-project.com/repo/ubuntu ${REL} main" | tee /etc/apt/sources.list.d/mono-official.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
 	--no-install-recommends \
 	--no-install-suggests \
	ca-certificates-mono \
	libcurl4-openssl-dev \
	mono-devel \
	mono-vbnc \
 echo "**** clean up ****" && \
 apt-get autoremove -y --purge  && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	#/var/cache/apt/* \
	/var/tmp/* \
	# clean mono aot cache.. not needed ?
	#rm -rf /usr/lib/mono/aot-cache/amd64/*
