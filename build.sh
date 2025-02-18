###
 # @Author: SpenserCai
 # @Date: 2023-08-17 11:04:55
 # @version: 
 # @LastEditors: SpenserCai
 # @LastEditTime: 2023-09-10 16:53:51
 # @Description: file content
### 
export GOOS=linux
go build -o "./release/sd-webui-discord"

# 判断是否安装了gcc-mingw-w64，如果没有则安装
if [ ! -f "/usr/bin/x86_64-w64-mingw32-gcc" ]; then
    echo "gcc-mingw-w64 not found, install gcc-mingw-w64"
    sudo apt install gcc-mingw-w64
fi

export CC=x86_64-w64-mingw32-gcc
export CXX=x86_64-w64-mingw32-g++
export GOOS=windows
export GOARCH=amd64 
export CGO_ENABLED=1
go build -o "./release/sd-webui-discord.exe"
# 判断是否存在config.json
if [ ! -f "./release/config.json" ]; then
    echo "config.json not found, copy config.example.json to config.json"
    cp ./config.example.json ./release/config.json
fi

# 吧location目录和其中的文件复制到release目录，如果存在location目录则删除后再复制
if [ -d "./release/location" ]; then
    rm -rf ./release/location
fi
cp -r ./location ./release/location