package schema

import (
	"entgo.io/ent"
	"entgo.io/ent/schema/field"
)

// WeatherStation holds the schema definition for the WeatherStation entity.
type WeatherStation struct {
	ent.Schema
}

// Fields of the WeatherStation.
func (WeatherStation) Fields() []ent.Field {
	return []ent.Field{
		field.String("name"),
	}
}

// Edges of the WeatherStation.
func (WeatherStation) Edges() []ent.Edge {
	return nil
}
