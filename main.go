package main

import (
	"log"
	"os"
	"os/signal"
	"syscall"
)

// define a package level variable which will be used later to update the service
var build = "development"

func main() {
	log.Printf("starting the service on %v .. \n", build)
	defer log.Println("server is ended .. ")

	shutdown := make(chan os.Signal, 1)
	signal.Notify(shutdown, syscall.SIGTERM, syscall.SIGINT)

	<-shutdown

	log.Println("service is shutting down ..")
}
