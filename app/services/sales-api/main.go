package main

import (
	"log"
	"os"
	"os/signal"
	"runtime"
	"syscall"
)

// define a package level variable which will be used later to update the service
var build = "development"

func main() {
	// working with quotas of cpus ..
	cpus := runtime.GOMAXPROCS(0)

	log.Printf("starting the backend service on %v mode, and running with {%v} CPUs in parallel.. \n", build, cpus)
	defer log.Println("server is ended .. ")

	shutdown := make(chan os.Signal, 1)
	signal.Notify(shutdown, syscall.SIGTERM, syscall.SIGINT)

	<-shutdown

	log.Println("service is shutting down ..")
}
