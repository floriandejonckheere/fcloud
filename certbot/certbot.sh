##
# Issue Let's Encrypt certificates
#

# florian.dejonckhee.re / dejonckhee.re
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d florian.dejonckhee.re \
                  -d dejonckhee.re

# Reload NGINX configuration
docker exec thalarion_nginx_1 nginx -s reload
