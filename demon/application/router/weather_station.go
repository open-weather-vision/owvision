package router

import (
	"strconv"

	"github.com/gofiber/fiber/v3"
	"open-weather-vision.org/demon/controller"
)

func SetupWeatherStationRoutes(router fiber.Router, controller *controller.WeatherStation) {

	router.Get("/", func(c fiber.Ctx) error{
		items, err := controller.GetAllStations()

		if(err != nil){
			return err
		}

		return c.JSON(items)
	})

	router.Get("/:id", func(c fiber.Ctx) error{
		id := c.Params("id")
		parsedId, err := strconv.Atoi(id)

		if(err != nil){
			return err
		}

		items, err := controller.GetStation(parsedId)

		if(err != nil){
			return err
		}

		return c.JSON(items)
	})
}