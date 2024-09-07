# ObStack Docker

An obstack docker container with docker-compose setup.

## Setup example

_( !! Default security settings in this example are only for demo/test purposes !! )_

```
git clone https://github.com/obstack-org/obstack-docker.git
cd obstack-docker
docker-compose up -d

# Import database schema:
curl -s https://raw.githubusercontent.com/obstack-org/obstack/main/resources/obstack-schema-pgsql-v1.2.0.sql | docker exec -i obstack-db psql -U obstack obstack
```

Now login to your new installation on [http://yourserver/obstack](http://yourserver/obstack) with default authentication: _admin_/_admin_.

## Environment variables

Set in e.g. *docker-compose.yml*

* **DB_CONNECTIONSTRING**
	* PDO DSN (Data Source Name: [https://www.php.net/manual/en/ref.pdo-pgsql.connection.php](https://www.php.net/manual/en/ref.pdo-pgsql.connection.php))
* **SC_ENCRYPTIONKEY**
	* Encryption key, used e.g. in encryption of recoverable passwords. Ensure you have read the documentation!: [http://www.obstack.org/docs/?doc=general-configuration#configuring-recoverable-passwords](http://www.obstack.org/docs/?doc=general-configuration#configuring-recoverable-passwords)

## SSL Certificate

When starting the container it generates a self signed certificate if no certificate is set. There are two ways to set your own certificate:

**1. Shared Volumes**

```yaml
    volumes:
      - /path/to/server.pem:/etc/ssl/apache2/server.pem:ro
      - /path/to/server.key:/etc/ssl/apache2/server.key:ro
```

**2. Environment variables**

```yaml
    environment:
      SSL_CERTIFICATEFILE: |-
        -----BEGIN CERTIFICATE-----
		[certificate]
        -----END CERTIFICATE-----
      SSL_CERTIFICATEKEYFILE: |-
        -----BEGIN PRIVATE KEY-----
		[keyfile]
        -----END PRIVATE KEY-----
```
