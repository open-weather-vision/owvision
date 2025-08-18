# `/recorder`

[[Go back](../README.md)]

Responsible for connecting to a weather station via an interface and sending buffered weather station data to the demon via [MQTT](https://mqtt.org/).

## Recorder interfaces

Recorder interfaces make it possible to add support for _any kind of weather station_ (even a DIY one!). They tell the recorder how to interact with your weather station. Some of them are provided by the owvision authors itself, others are published by the community. As the interface is pretty easy, adding support for a new kind of weather station is straightforward.
