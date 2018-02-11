FROM klauer/caproto-docker:0.2.1 as build
MAINTAINER caproto <>

FROM scratch
COPY --from=build / /

USER softioc
