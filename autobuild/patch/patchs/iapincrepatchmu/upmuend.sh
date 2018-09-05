

if [ $? = 0 ]; then
    echo "更新成功!请重启iap!"
else
    echo "iap更新失败!"
    exit 1
fi

exit 0
