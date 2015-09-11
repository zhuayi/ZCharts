PROJECTNAME="ZCharts";
SDK="iphoneos";
INFOPATH="./Example/$PROJECTNAME/$PROJECTNAME-Info.plist";
XCWORKSPACE="./Example/$PROJECTNAME.xcworkspace";
SCHEME="ZCharts"
OUTPUT="./output"

ProvisioningProfile="Distribution_Rehab"
BundleIdentifier="com.baidu.bdg.rehab";


if [ ! -d $OUTPUT ]; then
    mkdir $OUTPUT
else
    rm -fr $OUTPUT;
fi;

echo "build sdk : $SDK";

CFBundleShortVersionString=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" $INFOPATH);

# 读取当前的
OLDCFBundleIdentifier=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" $INFOPATH);

# 替换新的
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BundleIdentifier" $INFOPATH;

OLDCFBundleIdentifier=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" $INFOPATH);


archivePath=$OUTPUT/$BundleIdentifier.xcarchive;
echo $archivePath;
exportPath=$OUTPUT/$BundleIdentifier;
echo $exportPath;


xctool -workspace $XCWORKSPACE -scheme $SCHEME -destination generic/platform=iOS -sdk $SDK -configuration release archive -archivePath $archivePath;


xcodebuild -exportArchive -archivePath $archivePath -exportPath $exportPath -exportFormat ipa -exportProvisioningProfile $ProvisioningProfile

# 改回原来的
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $OLDCFBundleIdentifier" $INFOPATH;


#打包dsym
tar -zcvf $exportPath.dSYMs.tar.gz $archivePath/dSYMs/

cp $archivePath/Products/Applications/$PROJECTNAME.app/Info.plist $OUTPUT

tar -zcvf $archivePath.tar.gz $archivePath

rm -fr $archivePath;