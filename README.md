# AndroidBlueView

测试环境1：
  手机：小米10、魅族20
  jdk：java11
  Android SDK：https://www.androiddevtools.cn/
  Android NDK：22.1.7171670（qt自动下载）
  问题：
    第一次编译卡在下载gradle-7.2-bin
    解决：手动安装gradle-7.2-bin
      网址：https://mirrors.aliyun.com/gradle/distributions/v7.2.0/
      将zip包放在此目录下面C:\Users\QH\.gradle\wrapper\dists\gradle-7.2-bin\2dnblmf4td7x66yl1d74lt32g\

二维码库编译：
构建工具：
  cmake:cmake version 3.30.3
编译器环境：
Windows：msvc2019
Android：Clang_arm64_v8a
ios：待定
AndroidBlueView
这是一个Android应用项目，用于展示二维码扫描功能，使用zxing-cpp库实现核心功能。

🧪 测试环境1
​​手机型号​​：小米10、魅族20
​​JDK版本​​：Java 11
​​Android SDK​​：https://www.androiddevtools.cn/
​​Android NDK​​：22.1.7171670（Qt自动下载）
⚠️ 遇到的问题
​​问题描述​​：第一次编译卡在下载gradle-7.2-bin
​​解决方案​​：手动安装gradle-7.2-bin
下载地址：https://mirrors.aliyun.com/gradle/distributions/v7.2.0/
放置路径：
C:\Users\QH\.gradle\wrapper\dists\gradle-7.2-bin\2dnblmf4td7x66yl1d74lt32g\
📦 二维码库编译（zxing-cpp）
🛠 构建工具
​​CMake​​：v3.30.3
