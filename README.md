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
|birth_year         |integer |null: false               | 
|birth_month        |integer |null: false               |
|birth_day          |integer |null: false               |

### Association

- has_many :items
- has-many :purchase_records

## itemsテーブル

|Column        |Type       |Options                        |
|--------------|-----------|-------------------------------|
|image         |text       |null: false,                   |
|name          |string     |null: false                    |
|description   |text       |null: false                    |
|category      |text       |null: false                    |
|status        |text       |null: false                    |
|postage       |text       |null: false                    |
|region        |string     |null: false                    |
|shipping_date |integer    |null: false                    |
|price         |integer    |null: false                    |
|seller_id     |references |null: false, foreign_key: true |
|buyer_id      |references |null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record

##　purchase_record

|Column    |Type       |Options                        |
|----------|-----------|-------------------------------|
|seller_id |references |null: false, foreign_key: true |
|buyer_id  |references |null: false, foreign_key: true |
|item-id   |references |null: false, foreign_key: true |

### Association

- has_many :users
- belongs_to :item
- has_one :delivery_address

##　delivery_addressテーブル

|Column        |Type       |Options                        |
|--------------|-----------|-------------------------------|
|postal_code   |integer    |null: false                    |
|prefecture    |string     |null: false                    |
|city          |string     |null: false                    |
|block         |string     |null: false                    |
|building_name |string     |null: false                    |
|phone_number  |integer    |null: false                    |
|buyer_id      |references |null: false, foreign_key: true |

### Association

- belongs_to :purchase_record