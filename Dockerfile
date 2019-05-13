FROM alpine:latest
MAINTAINER Andreas Rammhold (andreas@rammhold.de)
MAINTAINER Michael Link (email@michael.link)

# Install necessary stuff
RUN apk -U --no-progress upgrade && \
  apk -U --no-progress add taskd taskd-pki py-pip build-base python-dev openssl openssl-dev && \
  pip install bugwarrior "bugwarrior[jira]" configparser && \
  apk -U --no-progress del build-base python-dev openssl-dev

# Import build and startup script
COPY docker /app/taskd/

# Set the data location
ARG TASKDDATA
ENV TASKDDATA ${TASKDDATA:-/var/taskd}
ENV XDG_CONFIG_HOME ${TASKDDATA:-/var/taskd}

# Configure container
VOLUME ["${TASKDDATA}"]
EXPOSE 53589
ENTRYPOINT ["/app/taskd/run.sh"]
