#!/bin/bash

message="\$1"  # 获取传入的参数作为commit message

# 执行git命令
git add .
git commit -m "\$message"
git push origin master