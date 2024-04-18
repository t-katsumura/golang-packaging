# golang-packaging

`.rpm` and `.deb` packaging example for Golang applications.

```sh
apt install ./hello-1.0.0-1.x86_64.deb
apt remove --purge hello
```

```sh
rpm --nodeps -ivh ./hello-1.0.0-1.x86_64.rpm
rpm -e hello-1.0.0-1.x86_64
```

```sh
yum install ./hello-1.0.0-1.x86_64.rpm
yum remove -y hello
```

- <https://fpm.readthedocs.io/en/v1.15.1/>
- <https://github.com/grafana/alloy/blob/main/tools/make/packaging.mk>
- <https://tech.aptpod.co.jp/entry/2020/11/11/090000>
