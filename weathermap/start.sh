#!/bin/sh
cd /var/www/html/rf/weathermap
php ./weathermap --config l3.conf --output mymap.png --htmloutput l3.html
php ./weathermap --config l3.conf --output mymap.png --htmloutput index.html
php ./weathermap --config l3.conf --output l3.png
php ./weathermap --config fff-gw-cd1.conf --output fff-gw-cd1.png --htmloutput fff-gw-cd1.html
php ./weathermap --config nue2.conf --output nue2.png --htmloutput nue2.html
php ./weathermap --config euserv.conf --output euserv.png --htmloutput euserv.html
php ./weathermap --config fff-gw-reddog1.conf --output fff-gw-reddog1.png --htmloutput fff-gw-reddog1.html
php ./weathermap --config fff-gw-aquarius.conf --output fff-gw-aquarius.png --htmloutput fff-gw-aquarius.html
