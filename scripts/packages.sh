#!/bin/bash

#克隆的源码放在small文件夹
mkdir package/small
pushd package/small

#Packages
git clone -b main --depth 1 https://github.com/gxnas/ImmortalWrt-2410-Packages.git

popd

echo "packages executed successfully!"
