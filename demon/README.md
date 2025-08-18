# `/demon`

[[Go back](../README.md)]

Responsible for processing and managing each weather station's data inside a postgres database. It is also responsible for providing a convenient, secured interface in form of a RESTful API and websockets.

The source code resides in [`/application`](./application/). The api's specification is stored in [`/specification`](./specification/).

## Source Code Structure

```sh
application
├── controller              # Business logic for CRUD operations on the data entities
├── router                  # RESTful api routing
├── demon.go                # Demon application as struct, combines fiber, ent, ...
└── ent                     # Mostly generated ent code (ORM for postgres)
    ├── schema              # Schema definitions
    └── ...
```
