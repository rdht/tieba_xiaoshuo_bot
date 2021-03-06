Howto?
=====

1. `yum install postgresql-devel libxslt-devel postgresql-server libxml2-devel`
1. `bundle install`
2. 改名 `mv config/config.yml{.example,}`
3. 填上自己的信息（ **数据库使用 `Sequel` 作为 ORM gem** ）
4. `rake migration`
5. `bundle exec foreman start`

Fetch Rules?
============

* 每五分钟扫描一遍对应小说贴吧的置顶帖，如果扫到包含 *第xxx章*
  字样的就认定是更新的小说章节，然后发给订阅者
* 依赖百度贴吧的“置顶贴”，严重感谢贴吧吧务们

Try?
====

* 用 Gtalk 加好友 `crhan.xiaoshuo@gmail.com`
* 发送 `-?` 给机器人查看帮助
* 发送 `-sub 小说名字` 即可订阅小说

Commands
========

* -c/-check: 在 __被动__ 模式下查看积累的更新
* -s/-sub <小说名>: 订阅小说(请先检查对应贴吧是否有小说更新服务)
* -us/-unsub <小说名>: 退订已订阅的小说
* -sm/-switch_mode: 在 __主动__ 和 __被动__ 推送模式之间切换
* -m/-show_mode: 看看自己是在主动模式还是被动模式
* -h/-?/-help: 查看帮助
* -l/-ls/-list: 查看已订阅(包括已退订)的小说
* -fb/-feedback: 给我提意见啦
* -ab/-about: 无聊卖萌(女神提供的台词)
* -co/-count: 看看我已经发给你多少章小说啦

---------

# Change Log

## 1.3.3 / 2012-09-02 

  * 修正无法获得小说贴吧列表的问题  - 来自百度贴吧的奇怪更新, 如果在请求头中没有附带 BAIDUID 的 cookie 的话会导致 301 跳转
  * 修正 unsub 的方法重构后没有对应调整 worker 方法

## 1.3.2 / 2012-08-24 

  * 恢复五分钟一次在线检测
  * 修复 count 命令错误
  * 百度贴吧改版, 修改DOM搜索规则

## 1.3.1 / 2012-08-16 

  * bugs fixed

## 1.3.0 / 2012-08-14 

  * 增加 Fiction::name 的 unique 限制
  * 使用 simplecov 作为测试覆盖率工具
  * 分离 _测试_ 和 _发布_ 环境的数据库配置
  * 重构 worker/send.rb, model/user.rb, model/fiction.rb
  * 增加测试代码, 测试样本数据
  * 修复 migration 错误

## 1.2.4 / 2012-07-31 

  * 重构 bot.rb 并添加了短命令
  * Bot 不再使用单例模式, 并且尝试掉线后自动重连并重试发送
  * handle `Jabber::ServerDisconnected` and log it
  * Error log will log the hooked user now

## 1.2.3 / 2012-07-23 

  * 切换模式命令改为 `-switch`, 查看模式为 `-mode`

## 1.2.2 / 2012-07-21 

  * 修复无法在 send.rb 中 Subscription.update(:check_id => last_id) 的问题

## 1.2.1 / 2012-07-21 

  * 修复 worker/send.rb:45 的 send NilClass 问题

## 1.2.0 / 2012-07-20 

  * model 的 before_create 和 before_save 改为 mixin 形式混入. 正常 model 直接继承 Sequel::Model
  * 加入等待, 确保在 `-check` 时候小说按照顺序分发
  * 增加 `check` 模式和 `-check` 命令 使用 `-mode` 切换模式
  * 增加 `-count` 命令

## 1.1.0 / 2012-07-13 

  * 增加gtalk XMPP extension 属性, 默认保存消息历史到 gtalk 服务器

## 1.0.6 / 2012-06-26 

  * 修复 1.0.3 引入的重复章节检测的 Typo

## 1.0.5 / 2012-06-25 

  * IQ 查询并发导致 users 重复创建, 在数据库上增加 unique 限制

## 1.0.4 / 2012-06-25 

  * 修正由于 Typo 导致的 Bot 崩溃

## 1.0.3 / 2012-06-25 

  * 章节名重复检测有误, 修正

## 1.0.2 / 2012-06-24 

  * 失误：改了 rack 的配置文件名却没改 `Prockfile` 的配置


## 1.0.1 / 2012-06-24 

  * gtalk 密码分离到 config/config.yml 配置文件 准备开源

## 1.0.0 / 2012-06-24 

  * 自动添加现有好友到数据库
  * 检测重复章节名（一般是因为前一贴被删才有新的同名贴) 优化章节名(去除第一个“第”之前的文字，并且多个空格和并成一个)
  * 增加 `-list`, `-sub`, `-unsub`, `-help`, `-about`, `-feedback` 命令
  * 使用 `Sidekiq` 作为队列实现
  * 使用 `Sequel` 作为 ORM 组件
  * 使用 `PostgreSQL` 做数据存储
  * REXML bug fix: 使用
  	[ xmpp4r/issues/3 ]( https://github.com/ln/xmpp4r/issues/3#issuecomment-1739952 ) 补丁使 REXML 能正确处理 UTF 字符
