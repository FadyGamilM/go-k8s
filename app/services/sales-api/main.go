package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"runtime"
	"syscall"

	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

// define a package level variable which will be used later to update the service
var build = "development"

// func SpecifyCPUsThreads() error {
// 	if _, err := maxprocs.Set(); err != nil {
// 		return fmt.Errorf("nexprocs: %v", err)
// 	}
// 	return nil
// }

func main() {
	// working with quotas of cpus ..
	cpus := runtime.GOMAXPROCS(0)

	log.Printf("starting the backend service on %v mode, and running with {%v} CPUs in parallel.. \n", build, cpus)
	defer log.Println("server is ended .. ")

	// init the logger
	zlogger, err := initZLogger("SALES-API")
	if err != nil {
		fmt.Printf("error while initializing the zap logger instance : %v \n", err)
		os.Exit(1)
	}

	// if it doesn't fail we should call sync() metohd
	defer zlogger.Sync()

	// startup and shutting down sequeunce
	if err := run(zlogger); err != nil {
		zlogger.Errorw("startup", "ERROR", err)
		os.Exit(1)
	}

	// => manange shutting down the service
	shutdown := make(chan os.Signal, 1)
	signal.Notify(shutdown, syscall.SIGTERM, syscall.SIGINT)

	<-shutdown

	log.Println("service is shutting down ..")
}

func initZLogger(srv_name string) (*zap.SugaredLogger, error) {
	config := zap.NewProductionConfig()
	config.OutputPaths = []string{"stdout"}
	config.EncoderConfig.EncodeTime = zapcore.ISO8601TimeEncoder
	config.DisableStacktrace = true
	config.InitialFields = map[string]interface{}{
		"service": "SALES-API",
	}

	zlogger, err := config.Build()
	if err != nil {
		fmt.Printf("error constructing zap logger instance : %v \n", err)
		return nil, err
	}

	return zlogger.Sugar(), nil
}

func run(zlogger *zap.SugaredLogger) error {
	return nil
}
