# Readup All-in-One

**_Bootstrap a Readup instance using Docker Compose, using (almost) one command._** 

**Live example:** [koffiecouques.be](https://koffiecouques.be) & [ink.koffiecouques.be](https://ink.koffiecouques.be): my Readup (Ink) instances intended primarily for communities in Belgium.

Consider this bundle experimental, especially in terms of user experience, as Readup wasn't originally intended as a self-hosted platform, and lots of work remains to be done.


## Requirements

- A server with a recent-ish version of Docker. About 500 MB of free RAM (see below).
- A domain name for your Readup instance, to which you can add subdomains too (`api.`, `ink.`, and `static.`).
- Knowledge on how to set up a reverse proxy on your server & configure SSL (with certbot, or caddy-docker-proxy, see below)
- Some docker (compose) knowledge is helpful too.

## Installation

**There are two alternative compose files:**

- `docker-compose.yml`: assumes you are already using [caddy-docker-proxy](https://github.com/lucaslorentz/caddy-docker-proxy) as a reverse-proxy server on your host. It expects the external Docker network `caddy` to exist, as documented in the caddy-docker-proxy docs. This is a nice option if you're starting from scratch, since it auto-provisions SSL.
- `docker-compose.external.yml`: exposes port 8989 and can be used with your own reverse proxy. You should point all domains to `http://127.0.0.1:8989` on your existing host's reverse proxy. It should also handle SSL.

**Got your reverse proxy? Cool:**

1. Clone this repository onto your server (or `rsync` it)
2. Copy the `.env.sample` file into an `.env` file, and fill in the base domain where your instance should be available (like `READUP_HOST=koffiecouques.be`)
2. Point the following domains to your server's IP: `api.{YOUR_DOMAIN}`, `static.{YOUR_DOMAIN}`, `ink.{YOUR_DOMAIN}`, and `{YOUR_DOMAIN}` itself.
3. Run `docker compose up -d` OR `docker compose -f docker-compose.external.yml up -d`, depending on which reverse proxy setup you use.

## Limitations

The following sub-services are currently not yet supported or configured, however, by overriding the right files in the compose file, and fulfilling their requirements, you can probably get them to work!

- Email (!) (that includes all transactional emails like password reset email, and regular emails like "Article of the Day")
- Twitter (X) authentication
- Apple authentication
- Push notifications

## How to use this after installation?

It's probably easiest to start using Readup via your own **Readup Ink** frontend (`ink.{YOUR_DOMAIN}`), since that this service (while being very alpha-stage), does not depend on an app or browser extension for reading. It acts as a proxy for article content. Many Readup features are missing from Readup Ink though, so at this point you will need to visit the main website (`{YOUR_DOMAIN}`) for non-reading actions (like: posting, commenting, seeing leaderboards, ...)

If you're very determined, you can build, configure and distribute your own version of the Readup [browser extension](https://github.com/reallyreadit/web/tree/master/src/extension) and [Readup iOS app](https://github.com/reallyreadit/ios).

## Notes & Customization

### Encryption & API keys

If you don't provide the following 4 keys as environment variables, then the `config` container will generate them for you the first time your run it (and insert them in the .env file) `READUP_API_KEY`, `READUP_HASHID_SALT`, `READUP_READVER_ENC_KEY`, `READUP_TOKENIZATION_ENC_KEY`. See [./config/setup.sh](./config/setup.sh).

### Resources & requirements

Obviously this will depend on your usage, but you can start from these idle measurements:

- **RAM:** 1GB free RAM is probably advisable. I count about 350MB of used RAM when idling, but keep in mind that Docker also needs to build several container images on the deployment machine (including compiling some node dependencies from scratch), for which I've had to temporarily suspend some other services on my VPS with 2GB RAM so it could cope. 
- **Storage**: 2GB after installation (when naively counting image size): 249MB (api) + 162MB (proxy) + 326MB (web) + 710MB (db) + 18MB (cron) + 223 MB (ink) + 15.9 MB (config) = 1,703.9 MB


### Shoutout

The repository name is a reference to the amazing [Nextcloud AIO](https://github.com/nextcloud/all-in-one).
