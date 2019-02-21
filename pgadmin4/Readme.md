This directory contains the files required to create a docker container running pgAdmin.

Building
========

Whilst you can just use the Dockerfile directly, it requires that various pre-configuration steps are performed, for
example, the pgAdmin web code must be copied to `./web`, Sphinx documentation source must be copied to `./docs`
and `requirements.txt` is also expected to be in this directory.

The recommended (and easy) way to build the container is to do:

```console
cd $PGADMIN_SRC/
workon pgadmin-venv
make docker
```

This will call the build script $PGADMIN_SRC/pkg/docker/build.sh which will prepare a staging directory containing all
the required files, then build the container and push it to your repo.

Running
=======

Environment Variables
---------------------

The container will accept the following variables at startup:

*PGADMIN_DEFAULT_EMAIL*

This is the email address used when setting up the initial administrator account
to login to pgAdmin. This variable is required and must be set at launch time.

*PGADMIN_DEFAULT_PASSWORD*

This is the password used when setting up the initial administrator account to
login to pgAdmin. This variable is required and must be set at launch time.

*PGADMIN_ENABLE_TLS*

Default: <null>

If left un-set, the container will listen on port 80 for connections in plain
text. If set to any value, the container will listen on port 443 for TLS
connections.

When TLS is enabled, a certificate and key must be provided. Typically these
should be stored on the host file system and mounted from the container. The
expected paths are /certs/server.crt and /certs/server.key

*PGADMIN_LISTEN_PORT*

Default: 80 or 443 (if TLS is enabled)

Allows the port that the server listens on to be set to a specific value rather
than using the default.

*GUNICORN_THREADS*

Default: 25

Adjust the number of threads the Gunicorn server uses to handle incoming
requests. This should typically be left as-is, except in highly loaded systems
where it may be increased.

Mapped Files and Directories
----------------------------

The following files or directories can be mapped from the container onto the
host machine to allow configuration to be customised and shared between
instances:

*/var/lib/pgadmin*

This is the working directory in which pgAdmin stores session data, user files,
configuration files, and it's configuration database. Mapping this directory
onto the host machine gives you an easy way to maintain configuration between

invocations of the container.

*/pgadmin4/config_local.py*

This file can be used to override configuration settings in pgAdmin. Settings
found in config.py can be overridden with deployment specific values if
required.

*/pgadmin4/servers.json*

If this file is mapped, server definitions found in it will be loaded at launch
time. This allows connection information to be pre-loaded into the instance of
pgAdmin in the container.

*/certs/server.cert*

If TLS is enabled, this file will be used as the servers TLS certificate.

*/certs/server.key*

If TLS is enabled, this file will be used as the key file for the servers TLS
certificate.

Examples
--------

Run a simple container over port 80:

```
    docker pull dpage/pgadmin4
    docker run -p 80:80 \
        -e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
        -e "PGADMIN_DEFAULT_PASSWORD=SuperSecret" \
        -d dpage/pgadmin4
```
Run a TLS secured container using a shared config/storage directory in
/private/var/lib/pgadmin on the host, and servers pre-loaded from
/tmp/servers.json on the host:

```
    docker pull dpage/pgadmin4
    docker run -p 443:443 \
        -v "/private/var/lib/pgadmin:/var/lib/pgadmin" \
        -v "/path/to/certificate.cert:/certs/server.cert" \
        -v "/path/to/certificate.key:/certs/server.key" \
        -v "/tmp/servers.json:/servers.json" \
        -e "PGADMIN_DEFAULT_EMAIL=user@domain.com" \
        -e "PGADMIN_DEFAULT_PASSWORD=SuperSecret" \
        -e "PGADMIN_ENABLE_TLS=True" \
        -d dpage/pgadmin4
```
