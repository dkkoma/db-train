# setup

```
$ make up
```

# debug

以下でmysqlコンソールに入れます。
```
$ make debug/mysql
```

どうにもならなくなったら以下でDBを再作成してください。migration状態を全て吹っ飛ばしてイチからやり直せます。
```
$ make db/reset
```

以下でappコンテナに入れます。(あまり使わない想定
```
$ make debug/app
```

# 関連リポジトリ

## GitHub

* https://github.com/rubenv/sql-migrate
* https://github.com/dkkoma/sql-migrate-bin

## Docker Hub

* https://hub.docker.com/_/mysql/
* https://hub.docker.com/r/dkkoma/sql-migrate-bin/
