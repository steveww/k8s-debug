# K8s Debug

A little Docker image built on Alpine with some useful tools installed.

## Usage

The image is already built and pushed to Docker Hub. Use the script to deploy the image to your K8s cluster.

```shell
$ ./debug.sh -n my-app start
```

Deploys the image to the namespace `my-app` if a namespace is not given it will deploy to the `default` namespace.

Now that the image is running, get a shell to it.

```shell
$ ./debug.sh -n my-app conn
```

The image has some useful tools installed such as:

* curl
* wget
* nslookup
* ping
* nc

When you're finshed with it, delete it.

```shell
$ ./debug -n my-app del
```

