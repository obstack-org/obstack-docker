# ObStack Docker

An obstack docker container with docker-compose setup.

Setup example:
```
git clone https://github.com/obstack-org/obstack-docker.git
cd obstack-docker
docker-compose up -d

# Import database schema:
curl -s https://raw.githubusercontent.com/obstack-org/obstack/main/resources/obstack-schema-v1.sql | docker exec -i obstack-db psql -U obstack obstack
```

Now login to your new installation on [http://yourserver/obstack](http://yourserver/obstack) with default authentication: _admin_/_admin_.
