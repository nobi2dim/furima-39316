# README

## users テーブル

| Column                |  Type  | Options                   |
| --------------------- | ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| password              | string | null: false               |
| confirmation_password | string | null: false               |
| first_name            | string | null: false               |
| last_name             | string | null: false               |
| first_name_kana       | string | null: false               |
| last_name_kana        | string | null: false               |
| birth_date            | string | null: false               |

### Association

- has_many :items
- has_many :orders



## items テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| name      | string     | null: false                    |
| detail    | text       | null: false                    |
| postage   | string     | null: false                    |
| price     | interger   | null: false                    |
| shipment  | interger   | null: false                    |
| category  | references | null: false, foreign_key: true |
| sender    | references | null: false, foreign_key: true |
| condition | references | null: false, foreign_key: true |
| image     | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |
| order     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category
- belongs_to :sender
- belongs_to :condition
- has_one :order
- has_one :imege



## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |
| destination | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :item
- has_one :destination



## destinations テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | interger   | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| block        | text       | null: false                    |
| building     | text       | null: false                    |
| phone_number | interger   | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- has_one :order



## categories テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :items



## senders テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| prefecture | string | null: false |

### Association

- has_many :items



## conditions テーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| condition | string | null: false |

### Association

- has_many :items



## images テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| image  | string | null: false |

### Association

- has_one :items