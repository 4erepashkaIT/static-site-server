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

## Requirements
- SSH host alias `srv1` in `~/.ssh/config` (or run `SERVER=myhost ./deploy.sh`)
- rsync on both machines

## Server setup
1. `sudo apt install nginx rsync`
2. Create `/etc/nginx/sites-available/igor-site` with an HTTP-only block
   (`listen 80`, `server_name`, `root`), link it into `sites-enabled/`, remove the `default` link
3. `sudo nginx -t && sudo systemctl reload nginx`
4. `sudo apt install certbot python3-certbot-nginx && sudo certbot --nginx -d turtle-it.duckdns.org`
   — certbot adds the SSL lines; the result is `nginx/igor-site.conf` in this repo