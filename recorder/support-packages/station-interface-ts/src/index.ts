import * as grpc from "@grpc/grpc-js";
import {
    GetSensorStateRequest,
    GetStationDefinitionRequest,
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
