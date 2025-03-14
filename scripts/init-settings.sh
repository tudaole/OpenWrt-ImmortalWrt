#!/bin/bash
#=======================================================
# Description: OpenWrt-ImmortalWrt DIY script
# File name: init-settings.sh
# Lisence: MIT
# By: GXNAS
#=======================================================

echo "开始 DIY 配置……"
echo "========================="
build_date=$(TZ=Asia/Shanghai date "+%Y.%m.%d")

# 修改主机名字，修改你喜欢的就行（不能纯数字或者使用中文）
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-GXNAS'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/hostname='.*'/hostname='OpenWrt-GXNAS'/g" ./package/base-files/files/bin/config_generate

# 修改默认IP
sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i '/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF./d' package/lean/default-settings/files/zzz-default-settings

# 调整 x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' package/lean/autocore/files/x86/autocore

# 设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

# 默认 shell 为 bash
sed -i 's/\/bin\/ash/\/bin\/bash/g' package/base-files/files/etc/passwd

# samba解除root限制
sed -i 's/invalid users = root/#&/g' feeds/packages/net/samba4/files/smb.conf.template

# coremark跑分定时清除
sed -i '/\* \* \* \/etc\/coremark.sh/d' feeds/packages/utils/coremark/*

# 修改 argon 为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/Bootstrap theme/Argon theme/g' feeds/luci/collections/*/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/*/Makefile

# 最大连接数修改为65535
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 显示增加编译时间
echo "当前路径及递归的文件夹："
ls -lhR
echo "========================="
echo "package/emortal/default-settings/files/99-default-settings原文内容："
cat package/emortal/default-settings/files/99-default-settings
echo "========================="
sed -i "s/DISTRIB_REVISION='R[0-9]\+\.[0-9]\+\.[0-9]\+'/DISTRIB_REVISION='@R$build_date'/g" package/emortal/default-settings/files/99-default-settings
sed -i 's/ImmortalWrt /OpenWrt-ImmortalWrt-X64-全功能版 by GXNAS build/g' package/emortal/default-settings/files/99-default-settings
echo "增加编译时间后package/emortal/default-settings/files/99-default-settings的内容："
cat package/emortal/default-settings/files/99-default-settings
echo "========================="

# 修改右下角脚本版本信息
echo "feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm原文内容："
cat feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
echo "========================="
sed -i 's/<a class=\"luci-link\" href=\"https:\/\/github.com\/openwrt\/luci\" target=\"_blank\">Powered by <%= ver.luciname %> (<%= ver.luciversion %>)<\/a>/OpenWrt-ImmortalWrt-X64-全功能版 by GXNAS build @R'"$build_date"'/' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i 's|<a href="https://github.com/jerrykuku/luci-theme-argon" target="_blank">ArgonTheme <%# vPKG_VERSION %></a>|<a class="luci-link" href="https://wp.gxnas.com" target="_blank">🌐固件编译者：【GXNAS博客】</a>|' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
sed -i 's|<%= ver.distversion %>|<a href="https://d.gxnas.com" target="_blank">👆点这里下载最新版本</a>|' feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
echo "增加编译时间后feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm的内容："
cat feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer.htm
echo "========================="
echo "feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm原文内容："
cat feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm
echo "========================="
sed -i "/<a class=\"luci-link\"/d; /<a href=\"https:\/\/github.com\/jerrykuku\/luci-theme-argon\"/d; s|<%= ver.distversion %>|OpenWrt-ImmortalWrt-X64-全功能版 by GXNAS build @R$build_date|" feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm
echo "增加编译时间后package/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm的内容："
cat feeds/luci/themes/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm
echo "========================="

# 修改欢迎banner
cp -f $GITHUB_WORKSPACE/scripts/banner package/base-files/files/etc/banner

echo "========================="
echo " DIY 配置完成……"
