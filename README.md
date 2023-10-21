# テーブル設計

## usersテーブル

|Column             |Type    |Options                   |
|-------------------|--------|--------------------------|
|nickname           |string  |null: false               |
|email              |string  |null: false, unique: true |
|encrypted_password |string  |null: false               |
|family_name        |string  |null: false               |
|first_name         |string  |null: false               |
|family_name_kana   |string  |null: false               |
|first_name_kana    |string  |null: false               |
|birthday           |date    |null: false               | 


### Association

- has_many :items
- has-many :purchase_records

## itemsテーブル

|Column           |Type       |Options                        |
|-----------------|-----------|-------------------------------|
|name             |string     |null: false                    |
|description      |text       |null: false                    |
|category_id      |integer    |null: false                    |
|status_id        |integer    |null: false                    |
|postage_id       |integer    |null: false                    |
|region_id        |integer    |null: false                    |
|shipping_date_id |integer    |null: false                    |
|price            |integer    |null: false                    |
|user             |references |null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

##　purchase_records

|Column |Type       |Options                        |
|-------|-----------|-------------------------------|
|user   |references |null: false, foreign_key: true |
|item   |references |null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery_address

##　delivery_addressesテーブル

|Column          |Type       |Options                        |
|----------------|-----------|-------------------------------|
|postal_code     |string     |null: false                    |
|prefecture      |string     |null: false                    |
|city            |string     |null: false                    |
|block           |string     |null: false                    |
|building_name   |string     |null: false                    |
|phone_number    |integer    |null: false                    |
|purchase_record |references |null: false, foreign_key: true |

### Association

- belongs_to :purchase_record