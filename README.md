__このブランチはReactを導入したnuita#create-basic-api用です。[masterブランチ](https://github.com/ahis1503/nuita-docker)のコンテナといくつか違いがあります__

# nuita-docker

１コマンドで[Nuita](https://github.com/nuita/)の開発環境を立ち上げるためのコンテナ

## Nuitaを立ち上げる

```sh
docker run --name nuita-react -it -p 3001:3000 -p 4000:4000 ahis1503/nuita:react
```

以前のNuitaコンテナとかぶらないようにRails側のポートは3001になっている(フロントからAPIを叩くときのは調整が必要そう)

`git clone`と`bundle install`、`yarn install`はすでに実行されているので、直接railsを実行できる

mysqlが立ち上がるとコマンドを実行できる状態になるのでrailsを起動する

```sh
cd server/
# 最初の一回だけ実行する
rails db:setup
# コンテナ外からアクセスするためにホストを指定する
rails s -b 0.0.0.0
```

フロントのサーバーを立ち上げるために`docker exec -it nuita-react bash`で新たにシェルを開く

```sh
cd client/
yarn start
```

Ctrl+Dで抜けることができ、抜けるとコンテナが終了します(2回目以降の起動方法は変わるので下記を参照)

Visual Studio Code Remote - Containersを使ってAttach to Running Container...からnuitaを選択し、エクスプローラーで/nuitaを開くとすぐに開発を始められます

Nuita自体は常に最新になってるわけではないので必要に応じて`git pull`や`bundle install`などを実行してください

その他のコマンドなど
```sh
# 最初にdocker runで起動したものを止めたあとに起動する(2回目以降の起動方法)
# -itを指定しなければコマンドが実行できなくなる代わりにバックグラウンドで実行可能
docker start -it nuita-react
# コンテナ内でコマンドを実行する(別ウィンドウで実行したいときなどに使う)
docker exec -it nuita-react bash
# バックグラウンドで起動したコンテナを停止させる
docker stop nuita-react
# コンテナを削除する(ローカルのデータはすべて消えるので注意)
docker rm nuita-react
```

何かわからないことがあれば気軽にissueか[Twitter](https://twitter.com/ahis1503)から聞いてください
