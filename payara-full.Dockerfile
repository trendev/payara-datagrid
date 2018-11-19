FROM payara/server-full:5.183

LABEL maintainer="trendevfr@gmail.com"

ENV AS_ADMIN $PAYARA_PATH/bin/asadmin
ENV DOMAIN domain1
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin
ENV NEW_ADMIN_PASSWORD payara
ENV MEMORY_SIZE 1024

# Reset the admin password
RUN echo 'AS_ADMIN_PASSWORD='$ADMIN_PASSWORD'\n\
AS_ADMIN_NEWPASSWORD='$NEW_ADMIN_PASSWORD'\n\
EOF\n'\
> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='$NEW_ADMIN_PASSWORD'\n\
EOF\n'\
> /opt/pwdfile

RUN $AS_ADMIN start-domain $DOMAIN && \
$AS_ADMIN --user $ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password && \
$AS_ADMIN restart-domain $DOMAIN && \
$AS_ADMIN set configs.config.server-config.security-service.activate-default-principal-to-role-mapping=true --passwordfile=/opt/pwdfile && \
$AS_ADMIN set configs.config.server-config.admin-service.das-config.dynamic-reload-enabled=false --passwordfile=/opt/pwdfile && \
$AS_ADMIN delete-jvm-options --passwordfile=/opt/pwdfile -client:-Xmx512m && \
$AS_ADMIN create-jvm-options --passwordfile=/opt/pwdfile -server:-Xmx${MEMORY_SIZE}m:-Xms${MEMORY_SIZE}m:-Dfish.payara.classloading.delegate=false:-Duser.timezone=Europe/Paris  && \
$AS_ADMIN set-hazelcast-configuration --passwordfile=/opt/pwdfile --enabled=true --dynamic=true --clustermode multicast --multicastgroup 224.2.2.4 --multicastport 55000 --clustername mydatagrid --clusterpassword PASSW0RD --membergroup mygrp && \
$AS_ADMIN restart-domain $DOMAIN

COPY ./event-receiver-1.0-SNAPSHOT.war $AUTODEPLOY_DIR
COPY ./event-sender-1.0-SNAPSHOT.war $AUTODEPLOY_DIR

# Start the server in verbose mode
ENTRYPOINT $AS_ADMIN start-domain -v $DOMAIN
