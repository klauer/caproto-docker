FROM python:3.6
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

ENV CI_ROOT="/epics/ci"
ENV CI_SCRIPTS="$CI_ROOT/ci-scripts"

RUN git clone https://github.com/klauer/epics-on-travis $CI_ROOT

# R3.14
ENV BASE=R3.14.12.6 V4= BUSY=1-6-1 SEQ=2.2.5 ASYN=4-32 CALC=3-7 AUTOSAVE=5-9 SSCAN=2-11-1 MOTOR=6-9 AREADETECTOR=3-2
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-base.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-modules.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-areadetector.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-iocs.sh" ]

# R3.15
ENV BASE=R3.15.5 V4=4.7.0 BUSY=1-6-1 SEQ=2.2.5 ASYN=4-32 CALC=3-7 AUTOSAVE=5-9 SSCAN=2-11-1 MOTOR=6-9 AREADETECTOR=3-2
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-base.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-v4.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-modules.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-areadetector.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-iocs.sh" ]

# R3.16
ENV BASE=R3.16.1 V4=4.7.0 BUSY=1-6-1 SEQ=2.2.5 ASYN=4-32 CALC=3-7 AUTOSAVE=5-9 SSCAN=2-11-1 MOTOR=6-10 AREADETECTOR=3-2
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-base.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-v4.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-modules.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-areadetector.sh" ]
RUN ["/bin/bash", "-c", "source $CI_SCRIPTS/epics-config.sh && \
     bash $CI_SCRIPTS/install-epics-iocs.sh" ]
