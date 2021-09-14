#!/bin/bash

# By SkylineIsBack

echo "
           _____ ____   _____ 
     /\   / ____/ __ \ / ____|
    /  \ | |   | |  | | |     
   / /\ \| |   | |  | | |     
  / ____ \ |___| |__| | |____ 
 /_/    \_\_____\____/ \_____|
                              "
echo ""
echo "Installing Accent Color Overlay Compiler"
echo ""
pkg install openjdk-17 -y
pkg install aapt -y
pkg install openssl-tool -y
mkdir ACOC
mv make ACOC/
mv delete ACOC/
mv afterupdate ACOC/
mv android.jar ACOC/
mv apksigner.jar ACOC/
mv ACOC $HOME
cd $HOME/ACOC/
chmod +x make
chmod +x delete
chmod +x afterupdate
mkdir input
mkdir output
mkdir backup
mkdir keys
cd keys
openssl genrsa -3 -out temp.pem 2048
openssl req -new -x509 -key temp.pem -out releasekey.x509.pem -days 10000 -subj '/C=US/ST=California/L=San Narciso/O=Yoyodyne, Inc./OU=Yoyodyne Mobility/CN=Yoyodyne/emailAddress=yoyodyne@example.com'
openssl pkcs8 -in temp.pem -topk8 -outform DER -out releasekey.pk8 -nocrypt
shred --remove temp.pem
echo ""
echo "Successfully installed ACOC"