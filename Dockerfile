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
LABEL org.opencontainers.image.authors="developer@derpaul.net"
LABEL org.opencontainers.image.description="parc (Precise Audio Rip Container)"
LABEL org.opencontainers.image.title="parc"
LABEL org.opencontainers.image.version="1.0"

#-------------------------------------------------------------------------------
# Define container variables
#-------------------------------------------------------------------------------
ARG APK_OPTIONS="--no-cache"
ARG DIR_PARC="/parc"
ARG VER_BASH="5.2.37-r0"
ARG VER_CUETOOLS="2.2.6"
ARG VER_GIT="2.47.2-r0"
ARG VER_PICARD="2.12.3-r0"
ARG FLE_CUETOOLS="CUETools.sln"
ARG DIR_CUETOOLS="cuetools.net"

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
# Set application directory
#-------------------------------------------------------------------------------
WORKDIR ${DIR_PARC}

#-------------------------------------------------------------------------------
# Copy scripts
#-------------------------------------------------------------------------------
# Install parc script
COPY assets/entrypoint.sh ${DIR_PARC}/entrypoint.sh

#-------------------------------------------------------------------------------
# Clone CUETools.NET repository from GitHub
#-------------------------------------------------------------------------------
# Download code archive of CUETools.NET
RUN cd ${DIR_PARC} && git clone https://github.com/gchudov/cuetools.net.git

# Initialize submodules
RUN cd ${DIR_PARC} && cd ${DIR_CUETOOLS} && git submodule init

# Update submodules
RUN cd ${DIR_PARC} && cd ${DIR_CUETOOLS} && git submodule update

#-------------------------------------------------------------------------------
# Build CUETools.NET
#-------------------------------------------------------------------------------
# Compile CUETools.NET
RUN cd ${DIR_PARC} && cd ${DIR_CUETOOLS} && dotnet build ${FLE_CUETOOLS}

#-------------------------------------------------------------------------------
# Run container
#-------------------------------------------------------------------------------
ENTRYPOINT ["/parc/entrypoint.sh"]
