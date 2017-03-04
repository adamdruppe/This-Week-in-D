#!/bin/bash

./makerss
cd ../web
cp * /var/www/htdocs/this-week-in-d
cd /var/www/htdocs/this-week-in-d
for i in *.html *.css *.rss twid-latest.js; do gzip -f "$i"; zcat "$i".gz > "$i"; done
