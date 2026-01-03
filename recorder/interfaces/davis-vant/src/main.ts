import {
    SensorDefinition,
    SensorState,
    startInterface,
    StationDefinition,
} from "@owvision/station-interface-ts";
import { WeatherStationAdvanced } from "vantjs/weather-station";

const device = await WeatherStationAdvanced.connect({
    path: "COM4",
    rainCollectorSize: "0.2mm",
    units: {
        elevation: "m",
        evoTranspiration: "mm",
        humidity: "%",
        leafTemperature: "°C",
        pressure: "hPa",
        rain: "mm",
        soilMoisture: "cb",
        soilTemperature: "°C",
        solarRadiation: "W/m²",
        temperature: "°C",
        wind: "km/h",
    },
});

const realtime = device.createDetailedRealtimeDataContainer({
    updateInterval: 10,
});

await startInterface({
    async getSensorState(request) {
        const result = SensorState.create({
            createdAt: Date.now(),
        });
        if (request.name === "temp_out") {
            result.unitId = "celsius";
            result.value = realtime.tempOut ?? undefined;
        }
        return result;
    },

    async getStationDefinition(request) {
        return StationDefinition.create({
            name: "My cool station",
            latitude: 49.8167,
            longitude: 7.79992,
            sensors: [
                SensorDefinition.create({
                    name: "temp_out",
                    element: "temperature",
                    recordIntervalSeconds: 10,
                }),
            ],
            version: 1,
        });
    },
});
