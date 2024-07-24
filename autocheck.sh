#!/bin/bash

t=./ad.txt
newfile=./temp.txt # A new file for reading and writing

# 下载Potterli20文件列表内容到newfile
while read -r i; do
    if curl -s "$i" >> $newfile; then
        echo "下载成功"
    else
        echo "下载失败"
    fi
done << EOF
https://github.com/Potterli20/file/releases/download/github-hosts/Accelerate-Hosts.txt
https://github.com/Potterli20/file/releases/download/github-hosts/gfw-hosts.txt
https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-hosts.txt
https://raw.githubusercontent.com/fordes123/hosts_generator/main/hosts
https://raw.hellogithub.com/hosts
https://onedrive-hosts.learningman.top/
EOF

# 下载其他文件列表内容到t
while read -r i; do
    if curl -s "$i" >> $t; then
        echo "下载成功"
    else
        echo "下载失败"
    fi
done << EOF
https://raw.githubusercontent.com/rentianyu/Ad-set-hosts/master/xiaobeita/hosts
https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt
https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt
https://raw.githubusercontent.com/8680/GOODBYEADS/master/dns.txt
EOF

# 去除重复行
sort -u $newfile -o $newfile
sort -u $t -o $t

# 去除以"!"开头的行和以"#"开头的注释行
sed -i '/^!/d;/^#/d' $t
sed -i '/^!/d;/^#/d' $newfile

# 为AC生成hosts文件
echo -e "# $(date '+%Y-%m-%d %T')\n# 杂项工厂实验项目，请勿商用\n" > ./rules/ac/hosts
sed -n '/^0\.0\.0\.0/p' $newfile >> ./rules/ac/hosts

# 为AD生成hosts文件
echo -e "# $(date '+%Y-%m-%d %T')\n# 杂项工厂实验项目，请勿商用\n" > ./rules/ad/hosts
cat $t >> ./rules/ad/hosts

rm $newfile
rm $t
echo "更新hosts成功"

# # # 下载去广告hosts合并并去重

# # t=./ad.txt

# # # curl -s https://gitee.com/qiusunshine233/hikerView/raw/master/ad_v1.txt > $t

# # # sed -i 's/\&\&/\n/g' $t

# # # curl -s https://gitee.com/qiusunshine233/hikerView/raw/master/ad_v2.txt >> $t

# # # sed -i '/\(\/\|@\|\*\|^\.\|\:\)/d;s/^/127.0.0.1 /g' $t && echo "海阔影视hosts导入成功"
# # # https://raw.githubusercontent.com/Licolnlee/AdBlockList/master/AdBlockLiteTest-dnsmasq
# # #https://raw.githubusercontent.com/BlackJack8/iOSAdblockList/master/Hosts.txt



# # while read i;do curl -s "$i">>$t&&echo "下载成功"||echo "下载失败";done<<EOF
# # https://raw.githubusercontent.com/rentianyu/Ad-set-hosts/master/xiaobeita/hosts
# # https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt
# # https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt
# # https://raw.githubusercontent.com/8680/GOODBYEADS/master/dns.txt
# # EOF
# # # 保留必要host
# # #https://raw.githubusercontent.com/hoshsadiq/adblock-nocoin-list/master/hosts.txt

# # #https://raw.githubusercontent.com/VeleSila/yhosts/master/hosts
# # #https://hblock.molinero.dev/hosts_adblock.txt
# # #https://raw.githubusercontent.com/Goooler/1024_hosts/master/hosts
# # #https://raw.githubusercontent.com/ilpl/ad-hosts/master/hosts
# # #https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-domains.txt
# # #https://raw.githubusercontent.com/Amazefcc233/no-ads-hosts/master/hosts
# # #https://raw.githubusercontent.com/easonjim/blackhosts/master/hosts
# # #https://raw.githubusercontent.com/E7KMbb/AD-hosts/master/system/etc/hosts
# # #https://adaway.org/hosts.txt
# # #https://raw.githubusercontent.com/jdlingyu/ad-wars/master/sha_ad_hosts
# # #https://raw.githubusercontent.com/jdlingyu/ad-wars/master/hosts
# # #https://cdn.jsdelivr.net/gh/neoFelhz/neohosts@gh-pages/127.0.0.1/full/hosts
# # #https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts
# # #https://raw.githubusercontent.com/TG-Twilight/AWAvenue-Ads-Rule/main/AWAvenue-Ads-Rule.txt
# # # sed -i '/^\(127\|0\|::\)/!d;s/0.0.0.0/127.0.0.1/g;/ip6-/d;/localhost/d;s/#.*//g;s/\s\{2,\}//g;/tencent\|c\.pc/d' $t

# # # 去除重复行
# # sort -u $t -o $t

# # # 去除以"!"开头的行和以"#"开头的注释行
# # sed -i '/^!/d;/^#/d' $t

# # # 修改规则为"||domain^"
# # #sed -i 's/^\(127\|0\|::\)/||/g;s/0.0.0.0/||/g;/ip6-/d;/localhost/d;s/#.*//g;s/\s\{2,\}//g;/tencent\|c\.pc/d' $t

# # # # 提取域名
# # # awk -F"\\^" '{print $1}' $t > domains

# # # # 检查重复域名
# # # sort domains | uniq -d > duplicate_domains

# # # # 去除重复域名
# # # if [ -s duplicate_domains ]; then
# # #     echo "重复的域名："
# # #     cat duplicate_domains
# # #     echo "正在从ad.txt中去除重复域名..."
# # #     cp $t $t.bak
# # #     while read domain; do
# # #         sed -i "/$domain/d" $t
# # #     done < duplicate_domains
# # #     echo "去除重复域名完成"
# # #     rm $t.bak
# # # else
# # #     echo "没有重复的域名"
# # # fi

# # # # 清理临时文件
# # # rm domains duplicate_domains

# # # 更新hosts
# # # 更新hosts
# # f=./hosts
# # (echo -e "# $(date '+%Y-%m-%d %T')\n# 杂项工厂实验项目，请勿商用\n" && sort -u $t) > $f && rm $t && echo "更新hosts成功" || echo "更新hosts失败..."
# # # (echo -e "# `date '+%Y-%m-%d %T'`\n# 杂项工厂实验项目，请勿商用\n" && sort -u $t) >$f&&rm $t&&echo "更新hosts成功"||echo "更新hosts失败..."

# # # # 去除重复行
# # # sort -u $t -o $t

# # # # 去除以"!"开头的行
# # # sed -i '/^!/d' $t

# # # # 修改规则为"||domain^"
# # # sed -i 's/^\(127\|0\|::\)/||/g;s/0.0.0.0/||/g;/ip6-/d;/localhost/d;s/#.*//g;s/\s\{2,\}//g;/tencent\|c\.pc/d' $t

# # # # 更新hosts
# # # (echo -e "# `date '+%Y-%m-%d %T'`\n# 杂项工厂实验项目，请勿商用\n\n127.0.0.1 localhost\n::1 localhost\n" && sort -u $t) >$f&&rm $t&&echo "更新hosts成功"||echo "更新hosts失败..."

# #!/bin/bash

# t=./ad.txt
# newfile=./temp.txt # A new file for reading and writing

# while read i; do
#     curl -s "$i" >> $t
#     echo "下载成功" || echo "下载失败"
# done << EOF
# https://raw.githubusercontent.com/rentianyu/Ad-set-hosts/master/xiaobeita/hosts
# https://raw.githubusercontent.com/217heidai/adblockfilters/main/rules/adblockdns.txt
# https://raw.githubusercontent.com/afwfv/DD-AD/main/rule/DD-AD.txt
# https://raw.githubusercontent.com/8680/GOODBYEADS/master/dns.txt
# EOF

# while read i; do
#     curl -s "$i" >> $newfile
#     echo "下载成功" || echo "下载失败"
# done << EOF
# https://github.com/Potterli20/file/releases/download/github-hosts/Accelerate-Hosts.txt
# https://github.com/Potterli20/file/releases/download/github-hosts/gfw-hosts.txt
# https://github.com/Potterli20/file/releases/download/github-hosts/bilibili-hosts.txt
# https://raw.githubusercontent.com/fordes123/hosts_generator/main/hosts
# https://raw.hellogithub.com/hosts
# https://onedrive-hosts.learningman.top/
# EOF

# # 去除重复行
# sort -u $newfile -o $newfile
# sort -u $t -o $t

# # 去除以"!"开头的行和以"#"开头的注释行
# sed -i '/^!/d;/^#/d' $t
# sed -i '/^!/d;/^#/d' $newfile

# # 为AC生成hosts文件
# echo -e "# $(date '+%Y-%m-%d %T')\n# 杂项工厂实验项目，请勿商用\n" > ./rules/ac/hosts
# cat $newfile >> ./rules/ac/hosts

# # 为AD生成hosts文件
# echo -e "# $(date '+%Y-%m-%d %T')\n# 杂项工厂实验项目，请勿商用\n" > ./rules/ad/hosts
# sed -n '/^0\.0\.0\.0/,$p' $t >> ./rules/ad/hosts

# rm $newfile
# echo "更新hosts成功"

