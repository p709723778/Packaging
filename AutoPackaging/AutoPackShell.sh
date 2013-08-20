#!/bin/sh

#  AutoPackShell.sh
#  Gary
#
#  Created by Gary on 13-8-19.
#  Copyright (c) 2013年 Gary. All rights reserved.


#########################################################
#该脚本稍改一些文件路径,渠道信息,项目名称等即可使用
#
#需要注意的是   该shell文件和渠道号channel.dat文件在同一个目录下
#             Users下的用户需要根据自己用户名修改  我用的是Gary
#
#该文件还可以继续优化
#########################################################


#该路径是存放ipa和zip文件 里面只会产生一个zip文件,该文件是AppStore文件包
distDir="/Users/Gary/Desktop/Packages"

#发布文件路径
releaseDir="build/Distribution-iphoneos"

#项目引用的渠道号文件路径
sourceidFilePath="/Users/Gary/Desktop/AutoPackaging/AutoPackaging/sourceid.dat"

#项目名称(xcode左边列表中显示的项目名称)
targetName="AutoPackaging"       

#项目目录
projectPaht="/Users/Gary/Desktop/AutoPackaging"

#发布的版本号
version="1_0_0"

#先删除存在的这些文件
rm -rdf "$distDir"
rm -rdf "$releaseDir"

#再创建新的文件目录
mkdir "$distDir"
mkdir "$releaseDir"

####################上面是一些定义信息,下面code才是进行处理#########################
#便利渠道号,逐个打包
for line in $(cat channel.dat)   #读取所有渠道号channel文件 如:  AppStore:1000 {渠道名:渠道号}
do

    ipafilename=`echo $line|cut -f1 -d':'` #渠道名
    sourceid=`echo $line|cut -f2 -d':'`    #渠道号
    echo "ipafilename=$ipafilename"
    echo "sourceid=$sourceid"

    #ipa文件存放位置和命名
    ipapath="${distDir}/${targetName}_${version}_for_${sourceid}.ipa"

    #app文件存放位置和命名
    appfile="${releaseDir}/${targetName}.app"


    #clean项目   -sdk iphoneos6.1  这个根据项目使用sdk修改
    xcodebuild  -target "$targetName" -configuration Distribution   -sdk iphoneos6.1 clean
    rm -rdf "$releaseDir"  #为了防止没有clean完所写

    echo "***********************开始build app文件***********************"
    xcodebuild -project "${projectPaht}/${targetName}.xcodeproj" -target "$targetName" -configuration Distribution  -sdk iphoneos6.1 build

    #渠道名称和渠道号写进 项目引用文件sourceid.dat
    echo "$ipafilename:$sourceid" > $sourceidFilePath
    echo "sourceid.dat: "
    cat $sourceidFilePath

        #AppStore的话,就进行压缩处理
        if [ $ipafilename = "AppStore" ] ; then

            cd $releaseDir
            zip -r "${targetName}_${ipafilename}_${version}.zip" "${targetName}.app"
            mv "${targetName}_${ipafilename}_${version}.zip" $distDir 2> /dev/null
            cd ../..

        else

        #此工具主要用于将app文件打包成ipa格式的程序包。（主要用于已越狱手机）。
        #具体用法如下：
        #/usr/bin/xcrun -sdk iphoneos PackageApplication –v [{TARGET}.app] -o [{TARGET}.ipa] --sign [{Iphone Distribution:xxx}] –embed [{xxx.mobileprovision}]
        #其中：-v 对应的是app文件的绝对相对路径 –o 对应ipa文件的路径跟文件名 
        #-sign对应的是 发布证书中对应的公司名或是个人名  –embed 对应的是发布证书文件
        #注意如果对应的Distribution 配置中已经配置好了相关证书信息的话 –sign 和 –embed可以忽略
        
            echo "***********************开始打ipa渠道包***********************"
            #此处的–sign我忽略了,在项目中已配置好
            /usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipapath" –embed "embedded.mobileprovision"

        fi
        done

################下面根据自己需求改############

#这是自动打包结束后,复原原project的信息所用, 原始渠道号根据自己需求改就可以
echo "AppStore:1000" > $sourceidFilePath

#删除编译路径里的文件,如果想看build下文件信息,注释即可,如果看某个包的话,就要自己改上面的内容了
rm -rdf "build"
















