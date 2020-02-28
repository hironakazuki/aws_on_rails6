[![CircleCI](https://circleci.com/gh/hironakazuki/aws_on_rails6.svg?style=svg)](https://circleci.com/gh/hironakazuki/aws_on_rails6)

# 目次
-  概要
-  利用技術と内容
-  この課題を通して学んだこと
-  工夫した点
-  苦労した点
-  参考

# 概要
Rails6新機能action_textを使ったタスクの追加／変更／削除が可能 + redis, sidekiqでバックグラウンドでゴミデータ削除するwebページ

製作期間 2/1(土)~2/25(火)
## Webページ
https://hks-portfolio.work
# 利用技術と内容
## サーバサイド
-  利用技術
    - Ruby 2.6.3
    - Rails 6.0.2
    - radis
    - MySQL 5.7
    - nginx 1.15.8
-  内容
    - action_textを使ったrich_textフォームの実装
    - Rspecを使ったテスト( model, system )
    - redis, sidekiqを使ったバックグラウンドジョブ([詳しくはこちら](https://qiita.com/ruko_zss/items/bb02e755711456c85c52))
## フロントエンド
-  利用技術
    - Material Design for Bootstrap 4
## インフラ
-  利用技術
    - AWS ( VPC / ES2 / RDS / S3 )
    - CloudFlare
    - Docker 19.03.5
    - CircleCI 2
-  内容
    - 開発環境 / 本番環境をDockerで構築
    - 関連付けされてないs3の画像ファイルをバックグラウンドジョブで削除
    - Cloudflareによるhttps化
    - CIによるデプロイの自動化
        - GitHubへのpushがトリガー
        - masterブランチ＆テスト成功時のみデプロイ
# この課題を通して学んだこと
- AWSの各種サービスの基本概念や接続方法とその利用方法
- CircleCIの各種設定や利用方法
- Dockerの仕組み
- redisサーバを用いたsidekiqによる非同期処理
# 工夫した点
- 本番環境と開発環境でdockerの設定ファイルを分ける
- AWS CLIを用いて、デプロイ時のみCircleCIからEC2へのアクセスを許可する
# 苦労した点
- 以下２点の参考サイトが少なく、苦労した。
    - Docker + EC2を使った自動デプロイ
    - gem aws-sdk-s3を使ったs3操作
# 参考
- [AWS：ゼロから実践するAmazon Web Services。手を動かしながらインフラの基礎を習得 - Udemy](https://www.udemy.com/course/aws-and-infra/)
- [ハンズオンで学ぶ Ruby on Rails 6 < Action Text を支えるデータベースアソシエーション編 > - Udemy](https://www.udemy.com/course/ruby-on-rails-action-text/)
- [無料！かつ最短？で Ruby on Rails on Docker on AWS のアプリを公開するぞ。 - Qiita](https://qiita.com/at-946/items/1e8acea19cc0b9f31b98)
- [Docker + Rails + Puma + Nginx + MySQL - Qiita](https://qiita.com/eighty8/items/0288ab9c127ddb683315)
- [クジラに乗ったRuby: Evil Martians流Docker+Ruby/Rails開発環境構築（翻訳）](https://techracho.bpsinc.jp/hachi8833/2019_09_06/79035)
- [CircleCI2.0からEC2にアクセスするときだけ特定のIPを許可したい - Qiita](https://qiita.com/rintaro-ishikawa/items/02e6a63dbc90ea67a991)
- [Rails5.2でCircleCIビルドエラー。 - Qiita](https://qiita.com/murata0705/items/9c99fc715d8b987a5b6e)
- [Ruby on Rails5 から「aws-sdk-s3」を使って画像をアップロードする](https://blog.seiyamaeda.com/12645)