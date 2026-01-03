# `/daemon`

[[Go back](../README.md)]

Responsible for processing and managing each weather station's data inside a sqlite database. It is also responsible for providing a convenient, secured interface in form of a RESTful API (with websockets) and a grpc service.

Read the [specification of the REST API](./specification/tsp-output/schema/openapi.1.0.0.yaml).
