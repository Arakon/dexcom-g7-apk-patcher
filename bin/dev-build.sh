#!/bin/bash
DEXCOM_SRC_DIR="dexcom-dev"
DEXCOM_MOD_APK="dexcom.development.apk";
KEYSTORE_PATH="signing.keystore";
KEYSTORE_PASS="6dYlrOon6U1430fwj492dBjnYm8CN5zYcWdbVJ53GQIf7PExEV";
APKTOOL="bin/apktool_2.7.0.jar"
UBER_SIGNER="bin/uber-apk-signer-1.3.0.jar"
checkStatus () {
   [ $1 -eq 0 ] && { echo "   DONE ✅"; } || { echo "   FAILED ❌"; exit 1;}
}

echo "----------------------";
echo "Dexcom G7 Hacking Unit - DEVELOPMENT";
echo "----------------------";
echo "  Removing old apk...";
rm $DEXCOM_MOD_APK || true
checkStatus 0
echo "----------------------";
echo "  Building hacked dexcom apk...";
java -jar $APKTOOL b $DEXCOM_SRC_DIR -o $DEXCOM_MOD_APK --use-aapt2
checkStatus $?
echo "----------------------";
echo "  Signing new apk...";
java -jar $UBER_SIGNER -a $DEXCOM_MOD_APK \
--ks $KEYSTORE_PATH \
--ksAlias cert \
--ksPass $KEYSTORE_PASS \
--ksKeyPass $KEYSTORE_PASS \
--overwrite
checkStatus $?
echo "----------------------";
echo "  Installing apk on device...";
adb install $DEXCOM_MOD_APK;
checkStatus $?
echo "----------------------";
echo "APK $DEXCOM_MOD_APK successfully patched 🎉🎉🎉 and installed on your 📲";
