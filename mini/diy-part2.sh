#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改默认IP
sed -i 's/192.168.1.1/10.10.10.10/g' package/base-files/files/bin/config_generate

# Autocore
sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile

# Cpufreq
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g' package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# 移除重复软件包
rm -rf package/lean/luci-theme-argon
rm -rf package/lean/luci-app-netdata
rm -rf package/lean/luci-app-wrtbwmon
rm -rf package/lean/luci-app-jd-dailybonus

# 添加额外软件包
git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman package/luci-app-dockerman
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata

# 科学上网插件依赖
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/simple-obfs
svn co https://github.com/fw876/helloworld/trunk/trojan package/trojan

# Themes
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd

# 晶晨宝盒
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
sed -i "s|https.*/OpenWrt|https://github.com/haiibo/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/ophub/kernel/tree/main/pub/stable|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|ARMv8_MINI|g" package/luci-app-amlogic/root/etc/config/amlogic

# 流量监控
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-wrtbwmon package/luci-app-wrtbwmon
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/wrtbwmon package/wrtbwmon

# 修改插件名字
# sed -i 's/"CPU 性能优化调节"/"CPU性能调节"/g' `grep "CPU 性能优化调节" -rl ./`
sed -i 's/"挂载 SMB 网络共享"/"挂载网络"/g' `grep "挂载 SMB 网络共享" -rl ./`
sed -i 's/"Argon 主题设置"/"Argon 设置"/g' `grep "Argon 主题设置" -rl ./`
sed -i 's/"网络存储"/"存储"/g' `grep "网络存储" -rl ./`
sed -i 's/"带宽监控"/"统计"/g' `grep "带宽监控" -rl ./`

./scripts/feeds update -a
./scripts/feeds install -a
