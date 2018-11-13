# :star2: payara-datagrid :star2:
Payara datagrid build with Docker and using the Clustered CDI Events example [cdi-clustered-events](https://github.com/trendev/Payara-Examples/tree/master/payara-micro/cdi-clustered-events).

Datagrid _(stateless = no cluster, no deployment group)_ :
> * 2x server 5.183
> * 2x payara-micro 5.183

## Build the payara-micro image
> docker build -f payara-micro.Dockerfile -t trendev/payara-micro .

## Build the payara-server image
> docker build -f payara-full.Dockerfile -t trendev/payara-full .

## :sparkles: Compose and start the datagrid :sparkles:
> docker-compose up _(-d can be added in order to detach the containers)_


