package config

import "github.com/spf13/viper"

type Config struct {
	POSTGRES_USER     string `mapstructure:"POSTGRES_USER"`
	POSTGRES_PASSWORD string `mapstructure:"POSTGRES_PASSWORD"`
	POSTGRES_DB       string `mapstructure:"POSTGRES_DB"`
	REDIS_ADDR string
	REDIS_PASSWORD    string
	REDIS_BD          int
}

func InitConfig() (config *Config, err error) {
    viper.AddConfigPath("../.")
    viper.SetConfigType("env")

    viper.AutomaticEnv()

    err = viper.ReadInConfig()
    if err != nil {
        return
    }

    err = viper.Unmarshal(config)
    return
}
