#!/bin/bash

# 拉取仓库文件夹
merge_package() {
	# 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
	# 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
	# 示例:
	# merge_package main https://github.com/gxnas/OpenWrt_Build_x64_Packages package/gxnas-packages luci-app-eqos luci-app-openclash luci-app-ddnsto ddnsto 
	# merge_package master https://github.com/lisaac/luci-app-dockerman package/lean applications/luci-app-dockerman
	if [[ $# -lt 3 ]]; then
		echo "Syntax error: [$#] [$*]" >&2
		return 1
	fi
	trap 'rm -rf "$tmpdir"' EXIT
	branch="$1" curl="$2" target_dir="$3" && shift 3
	rootdir="$PWD"
	localdir="$target_dir"
	[ -d "$localdir" ] || mkdir -p "$localdir"
	tmpdir="$(mktemp -d)" || exit 1
        echo "开始下载：$(echo $curl | awk -F '/' '{print $(NF)}')"
	git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
	cd "$tmpdir"
	git sparse-checkout init --cone
	git sparse-checkout set "$@"
	# 使用循环逐个移动文件夹
	for folder in "$@"; do
		mv -f "$folder" "$rootdir/$localdir"
	done
	cd "$rootdir"
}

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

#UnblockNeteaseMusic
git clone -b js --depth 1 git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

#Packages
git clone -b main --depth 1 https://github.com/tudaole/OpenWrt-ImmortalWrt-Packages.git
merge_package openwrt-24.10 https://github.com/immortalwrt/luci package/custom

# 报错修复
rm -rf feeds/kenzok8/v2ray-plugin
rm -rf feeds/kenzok8/open-app-filter
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/adguardhome
rm -rf feeds/luci/applications/luci-app-turboacc
merge_package master https://github.com/xiangfeidexiaohuo/extra-ipk package/custom applications/luci-app-alist applications/luci-app-arpbind applications/luci-app-dae applications/luci-app-daed applications/luci-app-filebrowser applications/luci-app-filemanager applications/luci-app-firewall applications/luci-app-frpc applications/luci-app-frps applications/luci-app-mwan3 applications/luci-app-netdata applications/luci-app-socat applications/luci-app-syncdial applications/luci-app-transmission applications/luci-app-ttyd applications/luci-app-udpxy applications/luci-app-uhttpd applications/luci-app-unblockneteasemusic applications/luci-app-upnp applications/luci-app-usb-printer 

popd

echo "packages executed successfully!"
