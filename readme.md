# Readup All-in-One

Bootstraps a production Readup instance using docker.

## Requirements

A server with Docker and a domain name for your Readup instance, for which you can add subdomains too (`api.` and `static.`).

The compose file assumes you are already using [caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) on your server to reverse-proxy requests to containers, and to auto-provision SSL certificates. It expects the external Docker network `caddy` to exist, as documented in the caddy-docker-proxy docs. See below how to configure another reverse proxy.

## Usage

1. Clone this repository onto your server,
2. Copy the `.env.sample` file into an `.env` file, and fill in the base domain where your instance should be available
2. Point the following domains to your server's IP: `api.{YOUR_DOMAIN}`, `static.{YOUR_DOMAIN}`, and `{YOUR_DOMAIN}` itself.
3. Run `docker compose up -d`

## Notes

- If you don't provide the following 4 keys as environment variables, then the `config` container will generate them for you the first time your run it (and insert them in the .env file) `READUP_API_KEY`, `READUP_HASHID_SALT`, `READUP_READVER_ENC_KEY`, `READUP_TOKENIZATION_ENC_KEY`.

## Limitations

The following sub-services are currently not supported, because they would require extra steps to set up.
- Twitter (X) authentication
- Apple authentication
- Apple Push notifications

## Customization

### Other reverse proxies

One likely customization you may want to do is to plug into the reverse proxy system that you already have in place on the host, which is not caddy-docker-proxy.

To do this:
- remove the caddy network from `docker-compose.yml`
- publish port 80 on the `proxy` service to a port that you can point your reverse proxy to
    ```yml
    - ports:
        - 8080:80
    ```
- Handle SSL in your reverse proxy for the three domains, and point them all to your published proxy port (8080 in this example).