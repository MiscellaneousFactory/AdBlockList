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
https://hosts.nfz.moe/127.0.0.1/full/hosts
https://raw.githubusercontent.com/rentianyu/Ad-set-hosts/master/xiaobeita/hosts
https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts
https://gitee.com/lhzgl6587/hosts/raw/master/hosts
https://raw.githubusercontent.com/Amazefcc233/no-ads-hosts/master/hosts
https://raw.githubusercontent.com/easonjim/blackhosts/master/hosts
https://raw.githubusercontent.com/Licolnlee/AdBlockList/master/AdBlockLiteTest-dnsmasq
https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/iPv4Hosts.txt
https://hblock.molinero.dev/hosts_adblock.txt
https://files.extstars.com/hosts/hosts
https://abp.oisd.nl/
https://cats-team.coding.net/p/adguard/d/AdRules/git/raw/main/ad-domains.txt
https://raw.githubusercontent.com/fordes123/adg-rule/main/rule/hosts.txt
https://adrules.top/dns.tx
https://www.kbsml.com/wp-content/uploads/adblock/adguard/adg-kall-dns.tx
https://raw.githubusercontent.com/Cats-Team/AdRules/main/mod/rules/dns-rules.txt
https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-agh.tx
https://raw.githubusercontent.com/jdlingyu/ad-wars/master/sha_ad_hosts
https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt
https://adaway.org/hosts.txt
https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt
https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt
https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/full/hosts.txt
EOF

# 保留必要host
sed -i '/^\(127\|0\|::\)/!d;s/0.0.0.0/127.0.0.1/g;/ip6-/d;/localhost/d;s/#.*//g;s/\s\{2,\}//g;/tencent\|c\.pc/d' $t

# 更新hosts
(echo -e "# `date '+%Y-%m-%d %T'`\n# 杂项工厂实验项目，请勿商用\n\n127.0.0.1 localhost\n::1 localhost\n" && sort -u $t) >$f&&rm $t&&echo "更新hosts成功"||echo "更新hosts失败..."
