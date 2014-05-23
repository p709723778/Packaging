#!/bin/bash

#  AutoPackIPAShell.sh
#  Gary
#
#  Created by Gary on 14-5-23
#  Copyright (c) 2014年 Gary. All rights reserved.


#########################################################
#
#
#从ipa格式的母包生成其它渠道包的shell脚本实例
#需要注意的是   该shell文件和渠道号channel.dat文件在同一个目录下
# sourceipaname / appname / targetName 这些都要根据自己的包明 还有需求改动
#该文件还可以继续优化
#########################################################

sourceipaname="AutoPackaging.ipa" #你用XCode打包出来的 ipa 文件名称
appname="AutoPackaging.app"       #加压后Pauload目录项.app文件名需要根据自己的项目修改
targetName="AutoPackaging"        #母包名称
version="1.0.0"                   #版本号
zipTime=`date +%m_%d`             #获取系统时间     比如 5_23 格式 5月23日

PlistBuddy="/usr/libexec/PlistBuddy" #使用PlistBuddy 修改plist文件

plutil="plutil"                   #plutil工具 可以用来检查plist的语法，或者对plist文件进行格式转换。

distDir="${PWD}/pkgs"             #获取当前路径 创建pkgs文件夹   该文件夹是存放 批量打包产生的包

plistConfigname="channel.plist"  #这个是项目里配置渠道信息的plist文件   (批量打包修改的就是它)

channelListFile="channel.dat"   #这里是配置所有渠道信息的文件  channel.dat 或 channel.txt  两种格式都行,其他格式的我没测试过,可能其他格式的也可以

rm -rdf "${distDir}"  #删除
mkdir -p "$distDir" #创建

unzip ${sourceipaname}                 #解压母包文件

for line in $(cat ${channelListFile} )      #读取渠道号文件并进行循环
do
channelName=`echo $line|cut -f1 -d':'`
channelID=`echo $line|cut -f2 -d':'`
#输出信息
echo "channelID=$channelID"
echo "channelName=$channelName"

cd Payload
cd $appname

#设置app包里面的plist文件
${PlistBuddy} -c "set :channelID $channelID" ${plistConfigname}
${PlistBuddy} -c "set :channelName $channelName" ${plistConfigname}

#把channel.plist文件转换成二进制
${plutil} -convert binary1 ${plistConfigname}

#下面的操作是解压缩
if [ $channelName == "AppStroe" ];then
cd ..
zip -r "${targetName}_${version}_from_${channelID}_${channelName}_${zipTime}.zip" $appname #appstore二进制文件
mv "${targetName}_${version}_from_${channelID}_${channelName}_${zipTime}.zip" $distDir
cd ..
else
cd ../..
zip -r "${targetName}_${version}_from_${channelID}_${channelName}_${zipTime}.ipa" Payload   #打成其他渠道的包
mv "${targetName}_${version}_from_${channelID}_${channelName}_${zipTime}.ipa" $distDir
fi
done

#删除解压,再次执行就不会出现提示你是否覆盖信息
rm -rdf Payload