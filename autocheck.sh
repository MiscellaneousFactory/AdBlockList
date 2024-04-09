# 下载去广告hosts合并并去重

t=./hosts.txt
f=./hosts

curl -s https://gitee.com/qiusunshine233/hikerView/raw/master/ad_v1.txt > $t

sed -i 's/\&\&/\n/g' $t

curl -s https://gitee.com/qiusunshine233/hikerView/raw/master/ad_v2.txt >> $t

sed -i '/\(\/\|@\|\*\|^\.\|\:\)/d;s/^/127.0.0.1 /g' $t && echo "海阔影视hosts导入成功"

while read i;do curl -s "$i">>$t&&echo "下载成功"||echo "下载失败";done<<EOF
https://raw.githubusercontent.com/E7KMbb/AD-hosts/master/system/etc/hosts
https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts
https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts
https://raw.githubusercontent.com/Goooler/1024_hosts/master/hosts
https://raw.githubusercontent.com/rentianyu/Ad-set-hosts/master/xiaobeita/hosts
https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts
https://raw.githubusercontent.com/Amazefcc233/no-ads-hosts/master/hosts
https://raw.githubusercontent.com/easonjim/blackhosts/master/hosts
https://raw.githubusercontent.com/Licolnlee/AdBlockList/master/AdBlockLiteTest-dnsmasq
https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/Hosts.txt
https://hblock.molinero.dev/hosts_adblock.txt
https://adrules.top/dns.txt
https://raw.githubusercontent.com/jdlingyu/ad-wars/master/sha_ad_hosts
https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt
https://adaway.org/hosts.txt
https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt
https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/127.0.0.1/full/hosts
https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt
https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt
https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt
https://raw.githubusercontent.com/8680/GOODBYEADS/master/dns.txt
https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/AWAvenue-Ads-Rule.txt
EOF
#https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall-dns.txt
#https://raw.githubusercontent.com/zsakvo/AdGuard-Custom-Rule/master/rule/zhihu-strict.txt
#https://raw.githubusercontent.com/dallaslu/penzai-list/main/uBlacklist.txt
#https://www.i-dont-care-about-cookies.eu/abp/
#https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt
#https://easylist-downloads.adblockplus.org/easylist.txt
#https://easylist-downloads.adblockplus.org/easylistchina.txt
#https://easylist-downloads.adblockplus.org/easyprivacy.txt
#https://easylist-downloads.adblockplus.org/easylist-cookie.txt
# https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt
# https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/full/hosts.txt
# 保留必要host
sed -i '/^\(127\|0\|::\)/!d;s/0.0.0.0/127.0.0.1/g;/ip6-/d;/localhost/d;s/#.*//g;s/\s\{2,\}//g;/tencent\|c\.pc/d' $t

# 更新hosts
(echo -e "# `date '+%Y-%m-%d %T'`\n# 杂项工厂实验项目，请勿商用\n\n127.0.0.1 localhost\n::1 localhost\n" && sort -u $t) >$f&&rm $t&&echo "更新hosts成功"||echo "更新hosts失败..."
