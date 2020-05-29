## Buildstage ##
FROM lsiobase/alpine:3.9 as buildstage

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	unzip && \
 echo "**** grab pia configs ****" && \
 mkdir -p /root-layer/defaults/ && \
 curl -o \
	/tmp/nordvpn.zip -L \
	"https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip" && \
 unzip \
	/tmp/nordvpn.zip \
	-d /root-layer/defaults/

# copy local files
COPY root/ /root-layer/

## Single layer deployed image ##
FROM scratch

# Add files from buildstage
COPY --from=buildstage /root-layer/ /
