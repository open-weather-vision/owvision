package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/gofiber/fiber/v3"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"github.com/pkg/errors"
	"open-weather-vision.org/demon/controller"
	"open-weather-vision.org/demon/ent"
	"open-weather-vision.org/demon/router"
)

type Demon struct {
	db *ent.Client
	fiber *fiber.App
}

func NewDemon() (*Demon, error){
	demon := Demon{}

	godotenv.Load()
	err := demon.setupDatabaseConnection()
	if(err == nil){
		demon.setupFiber()
	}

	return &demon, err
}

func (demon *Demon) setupFiber(){
	demon.fiber = fiber.New()

	v1 := demon.fiber.Group("/v1");

	weatherStations := v1.Group("/weather-station");
	router.SetupWeatherStationRoutes(weatherStations, &controller.WeatherStation{ Ctx: context.Background(), Db: demon.db });

	log.Println("Successfully setup fiber")
}

func (demon *Demon) setupDatabaseConnection() error {
	user, hasUser := os.LookupEnv("DATABASE_USER")
	if(!hasUser){
		return errors.New("Missing environment variable 'DATABASE_USER'")
	}

	password, hasPassword := os.LookupEnv("DATABASE_PASSWORD")
	if(!hasPassword){
		return errors.New("Missing environment variable 'DATABASE_PASSWORD'")
	}

	databaseName, hasName := os.LookupEnv("DATABASE_NAME")
	if(!hasName){
		return errors.New("Missing environment variable 'DATABASE_NAME'")
	}

	port, hasPort := os.LookupEnv("DATABASE_PORT")
	if(!hasPort){
		return errors.New("Missing environment variable 'DATABASE_PORT'")
	}

	client, err := ent.Open("postgres", fmt.Sprintf("sslmode=disable host=localhost port=%s user=%s dbname=%s password=%s", port, user, databaseName, password))

	if(err != nil){
		return err;
	}

	log.Printf("Successfully connected to database '%s' on port %s as user %s\n", databaseName, port, user)

	err = client.Schema.Create(context.Background())
	if(err != nil){
		return err;
	}

	log.Printf("Successfully migrated schemas!")

	demon.db = client
	return nil
}

func (demon *Demon) Listen(config ...fiber.ListenConfig) error{
	port, hasPort := os.LookupEnv("REST_PORT")
	if(!hasPort){
		return errors.New("Missing environment variable 'REST_PORT'")
	}
	log.Printf("Starting fiber on port %s...", port)

	return demon.fiber.Listen(fmt.Sprintf(":%s", port), config...)
}

func (demon *Demon) Close(){
	fiberShutDownError := demon.fiber.Shutdown()

	if(fiberShutDownError != nil){
		log.Println(fiberShutDownError)
	}else{
		log.Println("Shutdown fiber")
	}

	demon.db.Close()
	log.Println("Closed database connection")
}