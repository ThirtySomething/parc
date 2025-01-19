# To build the container
# docker build -t parc .

# Shell into container
# docker exec -it parc /bin/bash

#-------------------------------------------------------------------------------
# Define global variables
#-------------------------------------------------------------------------------
# Container OS version
ARG VER_ALPINE="3.21.2"

# Use defined base image
FROM alpine:${VER_ALPINE}

#-------------------------------------------------------------------------------
# Set container information
#-------------------------------------------------------------------------------
LABEL org.opencontainers.image.authors="develper@derpaul.net"
LABEL org.opencontainers.image.description="P.A.R.C. (Precise Audio Rip Container)"
LABEL org.opencontainers.image.title="PARC"
LABEL org.opencontainers.image.version="1.0"

#-------------------------------------------------------------------------------
# Define container variables
#-------------------------------------------------------------------------------
ARG APK_OPTIONS="--no-cache"
ARG DIR_PARC="/parc"
ARG VER_BASH="5.2.37-r0"
# ARG VER_CUETOOLS="1.4.1-r3"
ARG VER_PICARD="2.12.3-r0"
ARG VER_GIT="2.47.2-r0"

#-------------------------------------------------------------------------------
# Update container OS
#-------------------------------------------------------------------------------
# Update package index
RUN apk update

# Update packages
RUN apk ${APK_OPTIONS} upgrade

#-------------------------------------------------------------------------------
# Install programs via apk
#-------------------------------------------------------------------------------
# Install bash
RUN apk add ${APK_OPTIONS} bash=${VER_BASH}

# Install cuetools
# RUN apk add ${APK_OPTIONS} cuetools=${VER_CUETOOLS}

# Install git
RUN apk add ${APK_OPTIONS} git=${VER_GIT}

# Install picard
RUN apk add ${APK_OPTIONS} picard=${VER_PICARD}

#-------------------------------------------------------------------------------
# Prepare .NET environment
#-------------------------------------------------------------------------------
# Install SDK
RUN apk add ${APK_OPTIONS} dotnet9-sdk

# Install runtime
RUN apk add ${APK_OPTIONS} aspnetcore9-runtime

#-------------------------------------------------------------------------------
# Clone CUETools.NET
#-------------------------------------------------------------------------------
# Clone repository
RUN git clone https://github.com/gchudov/cuetools.net

#-------------------------------------------------------------------------------
# Set application directory
#-------------------------------------------------------------------------------
WORKDIR ${DIR_PARC}

#-------------------------------------------------------------------------------
# Copy scripts
#-------------------------------------------------------------------------------
# Install parc script
COPY assets/entrypoint.sh ${DIR_PARC}

#-------------------------------------------------------------------------------
# Run container
#-------------------------------------------------------------------------------
ENTRYPOINT ["/parc/entrypoint.sh"]
