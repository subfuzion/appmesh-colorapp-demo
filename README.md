# Color App demo for App Mesh

This repo contains the Go source code that supports the documentation guide at [appmesh.dev](https://appmesh.dev).

The **Color App** is a simple microservice application that is useful for demonstrate core App Mesh traffic management and observability features. It consists of two services, a frontend service (`gateway`) that listens for HTTP requests at `/color` and makes a call to a backend service (`colorteller`) that responds with a configured color.

Each version of `colorteller` responds with different color. The purpose of the demo is to showcase App Mesh features for controlling traffic routing simply and seamlessly in a way that is transparent to the application.

This repo contains the following:
* A frontend microservice, called `gateway`
* A backend microservice, called `colorteller`
* A CLI, called `colorapp`, that makes it easy deploy the full stack to Fargate, including public load balancer, and experiment with routing. The point is to facilitate demos without getting bogged down excessively in distracting low level configuration and deployment details that detract from comprehension.

To install the Color App demo CLI on your system:

* If you have Go 1.12+ installed on your system, simply run

    $ go get github.com/subfuzion/meshdemo/cmd/colorapp

* Download the latest release for Linux (linux/amd64), macOS (darwin/amd64), or Windows (windows/amd64) from

    [appmesh.dev/releases](https://github.com/subfuzion/appmesh.dev/releases).

