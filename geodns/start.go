package main

import (
	"fmt"
	"os/exec"
)

func runPdns(c chan int) {
	exec.Command("/usr/sbin/pdns_server", "--guardian=no", "--daemon=no")
	c <- 1
}

func runRecursor(c chan int) {
	exec.Command("/usr/sbin/pdns_recursor", "--guardian=no", "--daemon=no")
	c <- 1
}

func runDnsdist(c chan int) {
	exec.Command("/usr/bin/dnsdist", "--supervised", "-u", " _dnsdist", "-g", "_dnsdist")
	c <- 1
}

func main() {
	pdns := make(chan int)
	recursor := make(chan int)
	dnsdist := make(chan int)

	go runPdns(pdns)
	go runRecursor(recursor)
	go runDnsdist(dnsdist)

	for true {
		select {
		case p := <-pdns:
			fmt.Printf("powerdns authoritative server exited, restarting it: %v\n", p)
			go runPdns(pdns)
		case r := <-recursor:
			fmt.Printf("powerdns recursor exited, restarting it: %v\n", r)
			go runRecursor(recursor)
		case d := <-dnsdist:
			fmt.Printf("dnsdist dns load balancer exited, restarting it: %v\n", d)
			go runDnsdist(dnsdist)
		}
	}
}
