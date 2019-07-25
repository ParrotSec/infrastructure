package main

import (
	"fmt"
	"os/exec"
)

func runPdns(c chan int) {
	i, err := exec.Command("/usr/sbin/pdns_server", "--guardian=no", "--daemon=no", "--write-pid=no", "--disable-syslog").Output()
	if err != nil {
		fmt.Printf("Error: %s\n\n%s", err, i)
		c <- 2
	} else {
		fmt.Printf("\n%s\n", i)
		c <- 1
	}
}

func runRecursor(c chan int) {
	i, err := exec.Command("/usr/sbin/pdns_recursor", "--guardian=no", "--daemon=no", "--write-pid=no", "--disable-syslog").Output()
	if err != nil {
		fmt.Printf("Error: %s\n\n%s", err, i)
		c <- 2
	} else {
		fmt.Printf("\n%s\n", i)
		c <- 1
	}
}

func runDnsdist(c chan int) {
	i, err := exec.Command("/usr/bin/dnsdist", "--supervised").Output()
	if err != nil {
		fmt.Printf("Error: %s\n\n%s", err, i)
		c <- 2
	} else {
		fmt.Printf("\n%s\n", i)
		c <- 1
	}
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
			fmt.Printf("powerdns authoritative server exited: %v\n", p)
		case r := <-recursor:
			fmt.Printf("powerdns recursor exited: %v\n", r)
		case d := <-dnsdist:
			fmt.Printf("dnsdist dns load balancer exited: %v\n", d)
		}
	}
}
