__このブランチはnuita#master用のコンテナです。Reactを導入したnuita#create-basic-apiの[reactブランチ](https://github.com/ahis1503/nuita-docker/tree/react)もあります__

# nuita-docker

１コマンドで[Nuita](https://github.com/nuita/)の開発環境を立ち上げるためのコンテナ

## Nuitaを立ち上げる

```sh
docker run --name nuita -it -p 3000:3000 ahis1503/nuita
```

`git clone`と`bundle install`、`yarn install`はすでに実行されているので、直接railsを実行できる

mysqlが立ち上がるとコマンドを実行できる状態になるのでrailsを起動する

```sh
# 最初の一回だけ実行する
rails db:setup
# コンテナ外からアクセスするためにホストを指定する
rails s -b 0.0.0.0
```

Ctrl+Dで抜けることができ、抜けるとコンテナが終了します(2回目以降の起動方法は変わるので下記を参照)

Visual Studio Code Remote - Containersを使ってAttach to Running Container...からnuitaを選択し、エクスプローラーで/appを開くとすぐに開発を始められます

Nuita自体は常に最新になってるわけではないので必要に応じて`git pull`や`bundle install`などを実行してください

その他のコマンドなど
```sh
# 最初にdocker runで起動したものを止めたあとに起動する(2回目以降の起動方法)
# -itを指定しなければコマンドが実行できなくなる代わりにバックグラウンドで実行可能
docker start -it nuita
# コンテナ内でコマンドを実行する(別ウィンドウで実行したいときなどに使う)
docker exec -it nuita bash
# バックグラウンドで起動したコンテナを停止させる
docker stop nuita
# コンテナを削除する(ローカルのデータはすべて消えるので注意)
docker rm nuita
```

何かわからないことがあれば気軽にissueか[Twitter](https://twitter.com/ahis1503)から聞いてください
