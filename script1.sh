#!/bin/bash

# If the file 'download' exists, rename it to 'recovery.img'
if [ -f download ]; then
    mv download recovery.img
    echo "File 'download' renamed to 'recovery.img'"
else
    echo "'download' file does not exist."
fi

# The rest of your script can follow here...
if [ -f recovery.img.lz4 ]; then
    lz4 -B6 --content-size -f recovery.img.lz4 recovery.img
fi

off=$(grep -ab -o SEANDROIDENFORCE recovery.img | tail -n 1 | cut -d : -f 1)
dd if=recovery.img of=r.img bs=4k count=$off iflag=count_bytes

if [ ! -f phh.pem ]; then
    openssl genrsa -out phh.pem 4096
fi
