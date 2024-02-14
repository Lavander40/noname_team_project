package neo4j

import "noname_team_project/config"

type Neo4j struct {
	conf *config.Config
}

func New(config *config.Config) *Neo4j {
	return &Neo4j{
		conf: config,
	}
}

func (n *Neo4j) Open() error {
	return nil
}

func (n *Neo4j) Close() {
}
