# Sample keys

## PGP keys

- [./0x52ADAB4B-sec.asc](./0x52ADAB4B-sec.asc)
- [./0x52ADAB4B-pub.asc](./0x52ADAB4B-pub.asc)

Created with <https://pgptool.org/>

Specs:

```txt
Name: hello
EMail: hello@noreply.com
Algorithm: RSA
KeySize: 4096
Expire: Never
Passphrase: hello
```

Keyid can be found with this command.

```sh
gpg --list-packets ./keys/0x52ADAB4B-sec.asc  | grep keyid
```

## RSA keys

- [./rsa-private.pem](./rsa-private.pem)
- [./rsa-public.pem](./rsa-public.pem)

Created with <https://cryptotools.net/rsagen>

Specs:

```txt
KeySize: 4096
```
