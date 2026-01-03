# `/recorder`

[[Go back](../README.md)]

Responsible for connecting to a weather station via an interface and sending buffered weather station data to the daemon via [gRPC](https://grpc.io/).

## Recorder interfaces

The recorder does never communicate directly with a weather station. It uses a _station interface_ for that.

A _station interface_ is a gRPC service, that runs on port `50051` and follows [this](../shared/protos/recorder.proto) proto definition (`service StationInterface`). It automatically gets detected by the owvision recorder when running. It's the bridge between a weather station and the recorder.

As gRPC is language agnostic, _station interfaces_ are too! Interfaces are written by the community. [Here](https://open-weather-vision.github.io/owvision/reference/supported-stations/) is a list of popular interfaces.

If there isn't a interface for your weather station, **don't worry!** You can develop one yourself. Either you learn about gRPC and write the gRPC service by yourself (it's not that difficult) or you use a support package.

### Support packages

To make the development more beginner friendly there are support packages available for the most popular languages. If you use them you don't have to learn anything about gRPC. It is highly recommended to use support packages.

-   [**station-interface-ts**](./support-packages/station-interface-ts/README.md): Support package for _typescript / javascript_.
