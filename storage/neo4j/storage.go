package neo4j

import (
	"context"
	"noname_team_project/config"

	"github.com/neo4j/neo4j-go-driver/v5/neo4j"
)

type Neo4j struct {
	conf *config.Config
	conn neo4j.SessionWithContext
}

func New(config *config.Config) *Neo4j {
	return &Neo4j{
		conf: config,
	}
}

func (n *Neo4j) Open() error {
	driver, err := neo4j.NewDriverWithContext("", neo4j.BasicAuth("user", "pass", ""))
	if err != nil {
		return err
	}
	session := driver.NewSession(context.Background(), neo4j.SessionConfig{AccessMode: neo4j.AccessModeWrite})

	n.conn = session
	return nil
}

func (n *Neo4j) Close() {
}
