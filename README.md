# :star2: payara-datagrid :star2:
Payara datagrid build with Docker and using the Clustered CDI Events example [cdi-clustered-events](https://github.com/trendev/Payara-Examples/tree/master/payara-micro/cdi-clustered-events).

Datagrid _(stateless = no cluster, no deployment group)_ :
> * 2x payara- server 5.183
> * 2x payara-micro 5.183

## 1. Build the payara-micro image
> docker build -f payara-micro.Dockerfile -t trendev/payara-micro .

## 2. Build the payara-server image
> docker build -f payara-full.Dockerfile -t trendev/payara-full .

## 3. :sparkles: Compose and start the datagrid :sparkles:
> docker-compose up _(-d can be added in order to detach the containers)_

## 4. Finally, test the communication between the grid instances
### Fire a message
curl http://localhost:18080/event-sender-1.0-SNAPSHOT/SendEventServlet?message=curl-message
### ... and check if it is cached in another instance
curl http://127.0.0.1:8080//event-receiver-1.0-SNAPSHOT/EventsServlet

### It works :+1:

