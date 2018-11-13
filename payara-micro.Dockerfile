FROM payara/micro

LABEL maintainer="trendevfr@gmail.com"

COPY ./event-receiver-1.0-SNAPSHOT.war $DEPLOY_DIR
COPY ./event-sender-1.0-SNAPSHOT.war $DEPLOY_DIR

CMD [ \
"--group",\
"mygrp",\
"--mcaddress",\
"224.2.2.4",\
"--mcport",\
"55000", \
"--clustername",\
"mydatagrid",\
"--clusterpassword",\
"PASSW0RD", \
"--deploy",\
"/opt/payara/deployments/event-receiver-1.0-SNAPSHOT.war",\
"--deploy",\
"/opt/payara/deployments/event-sender-1.0-SNAPSHOT.war"]
