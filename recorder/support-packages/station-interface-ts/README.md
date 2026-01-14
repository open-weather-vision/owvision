# @owvision/station-interface-ts

Support package thats helps you to write a station interface (using typescript or javascript) which automatically gets detected by owvision.

## Usage

```ts
import {
    GetSensorStateRequest,
    GetStationDefinitionRequest,
    startInterface,
} from "@owvision/station-interface-ts";

/* This function is called by owvision. It should read from the requested sensor. */
async function getSensorState(req: GetSensorStateRequest) {
    const state = SensorState.create({
        createdAt: Date.now(),
    });
    if (req.name === "temp_in") {
        state.unitId = "celsius";
        state.value = 21; // TODO: Query the sensor's value here
    } else if (req.name === "temp_out") {
        state.unitId = "celsius";
        state.value = 12; // TODO: Query the sensor's value here
    }
    return state;
}

/* This function is called by owvision. It should return a list of all available sensors. */
async function getStationDefinition(req: GetStationDefinitionRequest) {
    return StationDefinition.create({
        name: "My station",
        longitude: 23.1,
        latitude: 12.3,
        sensors: [
            SensorDefinition.create({
                name: "temp_in",
                element: "temperature",
                recordIntervalSeconds: 60,
            }),
            SensorDefinition.create({
                name: "temp_out",
                element: "temperature",
                recordIntervalSeconds: 60,
            }),
        ],
        version: 1, // Increase this value, if your station definition changed and you don't won't to lose your data
    });
}

// Starts the grpc service, the owvision recorder will automatically detect the station after some time.
await startInterface({
    getSensorState,
    getStationDefinition,
});
```

Read this [guide](./guides/01_starter.md) to get started.
