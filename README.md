# setup

```
$ make up
```

# migration

## migrationファイルを作成する

NAME=適当な名前を指定して `make migrate/new` をします。
```
$ make migrate/new NAME=create_hoge
```

以下のようにコンソールに出れば `db/migrations/20180912095158-create_hoge.sql` というファイルが出来ています。
※ 表示とは異なり `db/` 以下にファイルが出来ることに注意
```
Starting db_1day_mysql ... done
Created migration migrations/20180912095158-create_hoge.sql
```

## up

```
$ make migrate/up

Applied 2 migrations
```

`applied n migrations` みたいなメッセージが出れば成功しています。

## down

```
$ make migrate/down

Applied 1 migrations
```

## migration状態の確認

```
$ make migrate/status

+---------------------------------+-------------------------------+
|            MIGRATION            |            APPLIED            |
+---------------------------------+-------------------------------+
| 20180731131753-create_order.sql | 2018-09-03 11:03:43 +0000 UTC |
| 20180814154716-insert_data.sql  | 2018-09-03 11:03:43 +0000 UTC |
+---------------------------------+-------------------------------+
```

APPLIEDに日付が入ってればそこまで適用済み。noの場合は適用されていません。

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
