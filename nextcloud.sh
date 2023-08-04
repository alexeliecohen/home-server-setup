docker compose up -d
docker compose exec --user www-data nextcloud php occ config:system:set default_phone_region --value=CA
