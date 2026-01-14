import * as grpc from "@grpc/grpc-js";
import * as generated from "./index.js";
import type { UnaryCallback } from "@grpc/grpc-js/build/src/client.js";
import {
    GetSensorStateRequest,
    GetStationDefinitionRequest,
    SensorDefinition,
    SensorState,
    StationDefinition,
    StationInterfaceService,
    type StationInterfaceServer,
} from "./generated/recorder.js";
export * from "./generated/recorder.js";

interface StationInterface {
    /** Should read a value from the passed sensor. */
    getSensorState(request: GetSensorStateRequest): Promise<SensorState>;

    /** Should return a station definition (name, position, sensors, ...). */
    getStationDefinition(
        request: GetStationDefinitionRequest
    ): Promise<StationDefinition>;
}

/** Starts the station interface (by default on grpc port `50051`). */
export function startInterface(
    stationInterface: StationInterface,
    port = 50051
) {
    const server = new grpc.Server();

    const grpcService: StationInterfaceServer = {
        async getSensorState(call, callback) {
            const sensorState = await stationInterface.getSensorState(
                call.request
            );
            callback(null, sensorState);
        },
        async getStationDefinition(call, callback) {
            const stationDefinition =
                await stationInterface.getStationDefinition(call.request);
            callback(null, stationDefinition);
        },
    };

    server.addService(StationInterfaceService, grpcService);

    return new Promise<void>((res, rej) => {
        server.bindAsync(
            `127.0.0.1:${port}`,
            grpc.ServerCredentials.createInsecure(),
            (error, port) => {
                if (error) {
                    rej(error);
                }
                res();
            }
        );
    });
}

async function getSensorState(req: GetSensorStateRequest) {
    if (req.name === "temp_in") {
        return SensorState.create({
            createdAt: Date.now(),
            unitId: "celsius",
            value: 12, // Query the temperature inside from your station here
        });
    } else {
        return SensorState.create({
            createdAt: Date.now(),
            unitId: "celsius",
            value: 23.1, // Query the temperature outside from your station here
        });
    }
}

async function getStationDefinition(req: GetStationDefinitionRequest) {
    return StationDefinition.create({
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
        version: 1,
    });
}

await startInterface({
    getSensorState,
    getStationDefinition,
});
