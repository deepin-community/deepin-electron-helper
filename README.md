# deb包构建

获取该项目数据后，执行如下命令开始构建deb包

```bash
debuild -b -us -uc -tc
```



# 构建支持架构

- amd64
- arm64
- loongarch64



# 更新二进制包

## 已编译源码包获取方式

1. amd64 & arm64架构
   - Electron二进制分发仓库(淘宝源) https://registry.npmmirror.com/binary.html?path=electron/
   - 选择需要封装的版本
   - 找到对应架构压缩包。包格式一般为"electron-v版本-架构.zip"amd64为linux-x64，arm64为linux-arm64
   - 选择合适的压缩包下载
2. loongarch64架构
   - 浏览器打开地址 http://www.loongnix.cn/zh/api/electron/
   - 下载最新版本压缩包



## 放置已下载二进制包

- 将已下载的二进制包根据架构放置在src对应的目录中
- 下载的二进制包名不要修改文件名称
- 每次版本迭代需要对patch/info和patch/info_loongarch64zhongde"version"字段进行更新