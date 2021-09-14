#!/bin/bash
set -e
# By SkylineIsBack

clear
echo "
           _____ ____   _____ 
     /\   / ____/ __ \ / ____|
    /  \ | |   | |  | | |     
   / /\ \| |   | |  | | |     
  / ____ \ |___| |__| | |____ 
 /_/    \_\_____\____/ \_____|
                              "
echo "Accent Color Overlay Compiler"
echo ""
read -p "Name of the accent color: " color
read -p "Hex colour code to be used in light theme: " hexlight
read -p "Hex colour code to be used in dark theme: " hexdark
defaultlocation="$(dirname $(readlink -f $0))"
name="AccentColor"$color"Overlay"
cd $defaultlocation/input/
mkdir "$name"
cd $name
touch "AndroidManifest.xml"
echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>

<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\"
    package=\"com.android.theme.color.$color\">

    <overlay
        android:category=\"android.theme.customization.accent_color\"
        android:priority=\"600\"
        android:targetPackage=\"android\" />

    <application
        android:label=\"@string/accent_color_"$color"_overlay\" />
</manifest>" >> AndroidManifest.xml
touch "Android.mk"
echo 'LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
' >> Android.mk
echo "LOCAL_RRO_THEME := "$name"

LOCAL_PRODUCT_MODULE := true
" >> Android.mk
echo 'LOCAL_SRC_FILES := $(call all-subdir-java-files)

LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res
' >> Android.mk
echo "LOCAL_PACKAGE_NAME := "$name"
LOCAL_SDK_VERSION := current" >> Android.mk
echo '
include $(BUILD_RRO_PACKAGE)' >> Android.mk
mkdir "res"
cd res
mkdir values
cd values
touch "strings.xml"
echo '<?xml version="1.0" encoding="utf-8"?>
' >> strings.xml
echo "<resources xmlns:xliff=\"urn:oasis:names:tc:xliff:document:1.2\">
    <!-- Black accent color name application label. [CHAR LIMIT=50] -->
    <string name=\"accent_color_"$color"_overlay\" translatable=\"false\">$color</string>
</resources>" >> strings.xml
touch "colors_device_defaults.xml"
echo '<?xml version="1.0" encoding="UTF-8"?>
' >> colors_device_defaults.xml
echo "<resources>
    <color name=\"accent_device_default_light\">$hexlight</color>
    <color name=\"accent_device_default_dark\">$hexdark</color>
</resources>" >> colors_device_defaults.xml
cd $defaultlocation
export LD_LIBRARY_PATH=.
aapt package -f -F "$name.apk" -M "$defaultlocation/input/$name/AndroidManifest.xml" -S "$defaultlocation/input/$name/res" -I "$defaultlocation/android.jar"
java -jar apksigner.jar sign --key $defaultlocation/keys/releasekey.pk8 --cert $defaultlocation/keys/releasekey.x509.pem "$name.apk"
cp -r "$name.apk" backup/
mv "$name.apk" output/
rm -rf input/*
rm -rf "$name.apk.idsig"
echo ""
echo 'Do you want to copy this overlay to /vendor/overlay/ ? (y/n)'
read whattodo
if [[ "$whattodo" == "y" ]];
then
    su -c mount -o rw,remount /vendor
    su -c mv output/"$name.apk" /vendor/overlay/
    su -c chmod 644 /vendor/overlay/"$name.apk"
    echo ""
    echo "Copied successfully"
    echo ""
    read -p 'Do you want to reboot device? (y/n) ' rebootdevice
    if [[ "$rebootdevice" == "y" ]];
    then
        su -c reboot
    else
        echo "Exiting"
        exit
    fi
else
    rm -rf output/*
    echo "The compiled overlay is present $defaultlocation/backup/"
    echo "Exiting"
    exit
fi