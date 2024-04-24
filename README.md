# golang-packaging

`.rpm`, `.deb` and `apk` packaging example for Golang applications.

## How to

### Build Binary

```sh
CGO_ENABLED=0 go build -ldflags="-w -s" ./hello.go
```

### Create Package

```sh
# Create package
make fpm-rpm
# Install package
apt install ./hello-0.0.0-1.x86_64.deb
apt remove --purge hello
```

```sh
# Create package
make fpm-rpm
# Install package
rpm --nodeps -ivh ./hello-0.0.0-1.x86_64.rpm
# Remove package
rpm -e hello-0.0.0-1.x86_64
```

```sh
# Create package
make fpm-deb
# Install package
yum install ./hello-0.0.0-1.x86_64.rpm
# Remove package
yum remove -y hello
```

```sh
# Create package
make fpm-apk
# Install package
apk add --allow-untrusted  hello-0.0.0-1.x86_64.apk
# Remove package
apk del hello
```

## References

- <https://fpm.readthedocs.io/en/v1.15.1/>
- <https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package>
- <https://nfpm.goreleaser.com/>
- <https://github.com/grafana/alloy/blob/main/tools/make/packaging.mk>
