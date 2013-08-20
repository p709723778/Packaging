#!/bin/sh

#  AutoPackIPAShell.sh
#  Gary
#
#  Created by Gary on 13-8-19
#  Copyright (c) 2013年 Gary. All rights reserved.


#########################################################
#
#
#从ipa格式的母包生成其它渠道包的shell脚本实例
#需要注意的是   该shell文件和渠道号channel.dat文件在同一个目录下
#             Users下的用户需要根据自己用户名修改  我用的是Gary
#该文件还可以继续优化
#########################################################


sourceipaname="AutoPackaging.ipa"
appname="AutoPackaging.app"              #加压后Pauload目录项.app文件名需要根据自己的项目修改
distDir="/Users/Gary/Desktop/PackageIPAs"   #打包后文件存储目录
version="1.0.0"                     #版本号
targetName="AutoPackaging"          #母包名称

rm -rdf "$distDir "
mkdir "$distDir"

unzip $sourceipaname                #解压母包文件

for line in $(cat channel.dat)      #读取渠道号文件并进行循环
do
ipafilename=`echo $line|cut -f1 -d':'`
sourceid=`echo $line|cut -f2 -d':'`
echo "ipafilename=$ipafilename"
echo "sourceid=$sourceid"

cd Payload
cd $appname

echo "replace sourceid.dat before: "
cat sourceid.dat
echo "$sourceid" > sourceid.dat
echo "replace sourceid.dat after: "
cat sourceid.dat
if [ $ipafilename == "AppStroe" ];then
cd ..
zip -r "${targetName}_${version}_from_${sourceid}.zip" $appname #appstore二进制文件
mv "${targetName}_${version}_from_${sourceid}.zip" $distDir
cd ..
else
cd ../..
zip -r "${targetName}_${version}_from_${sourceid}.ipa" Payload   #打成其他渠道的包
mv "${targetName}_${version}_from_${sourceid}.ipa" $distDir
fi
done

#删除解压,再次执行就不会出现提示你是否覆盖信息
rm -rdf Payload













