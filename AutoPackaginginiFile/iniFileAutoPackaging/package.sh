#bin! /bin/sh

#cd /WorkSpace/InformationFor17173App

#echo $(cd "$(dirname "$0")";pwd)/
#echo $(cd /d %~dp0)/

cd $(cd "$(dirname "$0")";pwd)/                 #当前目录

xcodebuild clean -configuration Debug           #清理项目工程

distDir="$(cd "$(dirname "$0")";pwd)/OutIPAs"   #定义输出目录
releaseDir="build/Debug-iphoneos"               #编译目录   发布版本应该换成distribut的目录

sudo rm -rdf "$distDir"                         #新建输出目录
sudo mkdir -p "$distDir"


for line in $(cat data.dat)                     #循环读取渠道包内容
do
channelName=`echo $line`
echo "channelName=$channelName"

sed "s/Unknow/${channelName}/g" Config.ini > AutoPackaging/Config.ini      #渠道名写入配置文件，配置文件储存入工程目录

targetName="AutoPackaging"             #目标文件名，必须与Xcode中target 名字一致

#编译

rm -rdf  "$releaseDir"
ipapath="${distDir}/17173news_${channelName}.ipa"

xcodebuild -target "$targetName"  -configuration Debug -sdk iphoneos build          #编译文件  发布版本换用 Release 命令
appfile="${releaseDir}/${targetName}.app"


#打包 

if [ "$channelName" == "Apple" ]
then
cd $releaseDir
sudo zip -r "${targetName}_${channelName}.zip"  "${targetName}.app"                 #打包苹果官方用.app文件
sudo cp "${targetName}_${channelName}.zip" "${distDir}"
cd ../..

else
echo "================== $appfile ======== $ipapath ================ "
sudo /usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipapath"  --sign "iPhone Developer: Feng Yang (FE4QXTT4AF)"   #打包越狱用ipa文件
fi

done