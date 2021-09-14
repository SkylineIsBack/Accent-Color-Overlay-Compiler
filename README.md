# Accent Color Overlay Compiler
### ACOC

**Contents**
1) make: Executing this script creates a new overlay.
2) delete: Executing this script deletes the overlay specified by the user.
3) afterupdate: Executing this script recopies the overlay present in backup directory to the /vendor/overlay directory after a rom update has deleted the one you previously made.

**Prerequisites**
1) Install [termux](https://f-droid.org/en/packages/com.termux/) and give it storage and root permissions.
2) Download the code and extract it in a particular folder.
3) Now just `cd` into the extracted folder. For eg. I have downloaded the code in the Download folder and extracted it in a folder named ACOC so i just need to execute `cd /sdcard/Download/ACOC/`.
4) Now just execute the following line in termux :`bash installer.sh`.
5) Once installed, either exit from termux or just `cd` into the home directory by executing `cd $HOME`.
6) Now you can just execute the scripts by executing `./ACOC/<script-you-want-to-execute>` or by first `cd` 'ing into ACOC directory and then executing`./<script-you-want-to-execute>` in termux.

**Note**
1) Quality of code might be low but it would get better as i learn more.
2) Tested on Redmi Note 8.
3) Only works on Android 11.