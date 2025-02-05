#/bin/sh
NOWTIME=$(date +%Y-%m-%d-%H-%M-%S)
i=0
while ((i<=0))
do
echo "扫描NINA程序是否在线"
ps -fe|grep ninja|grep -v grep
if [ $? -ne 0 ]
then
    i=0
    echo $NOWTIME" 扫描结束！NINA 掉线了不用担心马上重启！"
    git clone https://gitee.com/mjf521/ninja.git /ql/ninja
    cd /ql/ninja/backend
    pnpm install
    pm2 start
    ps -fe|grep Daemon |grep -v grep 
            if [ $? -ne 1 ];then
            i=1
            echo $NOWTIME" NINA重启完成！"
            curl "https://api.telegram.org/bot1878231691:AAG42gjTy0kQWyFnlUkgWDGXhMlyPl4oW18/sendMessage?chat_id=1565562101&text=NINA已重启完成"
            fi
      
else
 i=1
 echo $NOWTIME" 扫描结束！NINA还在！"
fi
done

echo "开始扫描机器人是否在线！"
ps -fe|grep jbot|grep -v grep
if [ $? -ne 0 ]
then
 echo $NOWTIME" 扫描结束！不好了不好了机器人掉线了，准备重启！"
 nohup python3 -m jbot >/dev/null 2>&1 &
 echo $NOWTIME"  扫描结束！机器人准备重启完成！"
 curl "https://api.telegram.org/bot1878231691:AAG42gjTy0kQWyFnlUkgWDGXhMlyPl4oW18/sendMessage?chat_id=1565562101&text=扫描结束！机器人准备重启完成！"
else
 echo $NOWTIME" 扫描结束！机器人还在！" 
fi
echo "开始扫描静态解析是否在线！"
ps -fe|grep nginx|grep -v grep
if [ $? -ne 0 ]
then
 echo $NOWTIME" 扫描结束！Nginx静态解析停止了！准备重启！"
 nginx -c /etc/nginx/nginx.conf
 echo $NOWTIME" Nginx静态解析重启完成！"
 curl "https://api.telegram.org/bot1878231691:AAG42gjTy0kQWyFnlUkgWDGXhMlyPl4oW18/sendMessage?chat_id=1565562101&text= Nginx静态解析重启完成！"
else
 echo $NOWTIME"  扫描结束！Nginx静态解析正常呢！" 
fi
