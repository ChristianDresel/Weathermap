#!/bin/sh
cd /var/www/html/rf/weathermap
echo "1"
php ./weathermap --config l3new.conf --output mymap.png --htmloutput l3.html
echo "2"
php ./weathermap --config l3new.conf --output mymap.png --htmloutput index.html
php ./weathermap --config l3new.conf --output l3.png
php ./weathermap --config fff-gw-cd1.conf --output fff-gw-cd1.png --htmloutput fff-gw-cd1.html
php ./weathermap --config nue2.conf --output nue2.png --htmloutput nue2.html
php ./weathermap --config euserv.conf --output euserv.png --htmloutput euserv.html
#php ./weathermap --config fff-gw-reddog1.conf --output fff-gw-reddog1.png --htmloutput fff-gw-reddog1.html
php ./weathermap --config fff-gw-aquarius.conf --output fff-gw-aquarius.png --htmloutput fff-gw-aquarius.html
php ./weathermap --config zbau.conf --output zbau.png --htmloutput zbau.html
php ./weathermap --config merkur.conf --output merkur.png --htmloutput merkur.html
#php ./weathermap --config fff-gw-sw.conf --output fff-gw-sw.png --htmloutput fff-gw-sw.html
