# Static Site Server

My solution for the roadmap.sh project [Static Site Server](https://roadmap.sh/projects/static-site-server).

**Live:** https://turtle-it.duckdns.org

Stack: Ubuntu 24.04 VPS, nginx, rsync, ufw, Let's Encrypt (certbot)

## What's inside
- `site/` — the static site: HTML, CSS, an image
- `nginx/igor-site.conf` — the nginx server block, copied from the server
- `deploy.sh` — syncs `site/` to the server with rsync

## Deploy
```bash
./deploy.sh -n   # dry run: show what would change
./deploy.sh      # deploy
```

## Beyond the requirements
- ufw firewall: only SSH, 80 and 443 are open
- HTTPS with Let's Encrypt, HTTP→HTTPS redirect, automatic renewal via certbot.timer
- deploy.sh checks: index.html exists, no uppercase letters or spaces in file names, no absolute `/Users/` paths