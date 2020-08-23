##
# Issue Let's Encrypt certificates
#

# florian.dejonckhee.re / dejonckhee.re
echo "Refreshing certificate for florian.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d florian.dejonckhee.re \
                  -d dejonckhee.re

# floriandejonckheere.be
echo "Refreshing certificate for floriandejonckheere.be"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d floriandejonckheere.be

# registry.dejonckhee.re
echo "Refreshing certificate for registry.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d registry.dejonckhee.re

# trivial.dejonckhee.re
echo "Refreshing certificate for trivial.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d trivial.dejonckhee.re

# vault.dejonckhee.re
echo "Refreshing certificate for vault.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d vault.dejonckhee.re

# headbang.re
echo "Refreshing certificate for headbang.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d headbang.re

# ma.cache.headbang.re
echo "Refreshing certificate for ma.cache.headbang.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d ma.cache.headbang.re

# cloud.dejonckhee.re
echo "Refreshing certificate for cloud.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d cloud.dejonckhee.re

# torrents.dejonckhee.re
echo "Refreshing certificate for torrents.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d torrents.dejonckhee.re

# media.dejonckhee.re
echo "Refreshing certificate for media.dejonckhee.re"
certbot certonly --webroot \
                  --non-interactive \
                  --email florian@floriandejonckheere.be \
                  --agree-tos \
                  -w /etc/letsencrypt-data/ \
                  -d media.dejonckhee.re

# Reload NGINX configuration
docker exec thalarion_nginx_1 nginx -s reload
