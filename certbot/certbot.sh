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

# Reload NGINX configuration
docker exec thalarion_nginx_1 nginx -s reload
