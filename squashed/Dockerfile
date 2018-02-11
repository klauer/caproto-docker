FROM klauer/caproto-docker:0.2 as build
MAINTAINER caproto <>

USER root

RUN apt-get update
# get areadetector dependencies
RUN apt-get install -yq libhdf5-dev libx11-dev libxext-dev libxml2-dev libpng12-dev libbz2-dev libfreetype6-dev
RUN apt-get install -yq build-essential curl file git gawk re2c

# - setup the softioc user
RUN useradd -ms /bin/bash -d /epics softioc
RUN mkdir -p /epics/iocs /epics/src

USER softioc
USER root

RUN chown -R softioc:softioc /epics
USER softioc

FROM scratch
COPY --from=build /epics /epics
