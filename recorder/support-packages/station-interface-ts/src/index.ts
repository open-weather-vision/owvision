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

export enum UnitId {
    humidity_percent = "hum_percent",
    length_m = "m",
    length_cm = "cm",
    length_ft = "ft",
    length_in = "in",
    precipation_rate_mmph = "mmph",
    precipation_rate_inph = "inph",
    precipation_mm = "mm",
    precipation_lpm2 = "lpm2",
    precipation_inch = "inch",
    pressure_hpa = "hpa",
    pressure_inhg = "inhg",
    temperature_celsius = "celsius",
    temperature_kelvin = "kelvin",
    temperature_fahrenheit = "fahrenheit",
    winddir_degrees = "degrees",
    winddir_radians = "radians",
    windspeed_kmh = "kmh",
    windspeed_ms = "ms",
    windspeed_bft = "bft",
    windspeed_mph = "mph",
    windspeed_kn = "kn",
}

export enum SensorElement {
    precipationAccumulated = "precipationAccumulated",
    precipationRate = "precipationRate",
    snowHeight = "snowHeight",
    pressure = "pressure",
    temperature = "temperature",
    windSpeed = "windSpeed",
    windDirection = "windDirection",
    humidity = "humidity",
}

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
