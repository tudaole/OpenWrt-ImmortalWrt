#!/bin/bash

#删除feeds中的插件
# rm -rf ./feeds/packages/net/mosdns
# rm -rf ./feeds/packages/net/v2ray-geodata
rm -rf ./feeds/packages/net/geoview
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/chinadns-ng

#克隆依赖插件
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/pwpage

#克隆的源码放在small文件夹
mkdir package/small
pushd package/small

#Packages
git clone -b main --depth 1 https://github.com/tudaole/OpenWrt-ImmortalWrt-Packages.git

popd

echo "packages executed successfully!"
