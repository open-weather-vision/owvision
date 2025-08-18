package controller

import (
	"context"

	"open-weather-vision.org/demon/ent"
)

type WeatherStation struct {
	Ctx    context.Context
	Db *ent.Client
}

// Gets all weather stations.
func (c *WeatherStation) GetAllStations()  ([]*ent.WeatherStation, error) {
	return c.Db.WeatherStation.Query().All(c.Ctx)
}

// Gets a single weather stations.
func (c *WeatherStation) GetStation(id int)  (*ent.WeatherStation, error) {
	return c.Db.WeatherStation.Get(c.Ctx, id)
}