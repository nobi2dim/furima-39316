# README

## users テーブル

| Column                |  Type  | Options                   |
| --------------------- | ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| confirmation_password | string | null: false               |
| first_name            | string | null: false               |
| last_name             | string | null: false               |
| first_name_kana       | string | null: false               |
| last_name_kana        | string | null: false               |
| birth_date            | date   | null: false               |

### Association

- has_many :items
- has_many :orders



## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| detail       | text       | null: false                    |
| postage_id   | integer    | null: false                    |
| price        | integer    | null: false                    |
| shipment_id  | integer    | null: false                    |
| category_id  | integer    | null: false                    |
| sender_id    | integer    | null: false                    |
| condition_id | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category
- belongs_to :sender
- belongs_to :condition
- has_one :order



## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination



## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order



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