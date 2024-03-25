<!-- ## users

| Column                | Type   | Options                   |
| --------------------- | ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| password              | string | null: false, unique: true |
| password_confirmation | string | null: false               |
| last_name             | string | null: false               |
| first_name            | string | null: false               |
| last_name_kana        | string | null: false               |
| first_name_kana       | string | null: false               |
| birthday              | date   | null: false               |

### Association
- has_many :items
- has_many :purchase_records


## items

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| name                  | string     | null: false, limit: 40         |
| description           | text       | null: false, limit:1000        |
| category              | string     | null: false                    |
| condition             | string     | null: false                    |
| shipping_cost_burden  | string     | null: false                    |
| ship-from_region      | string     | null: false                    |
| shipping_days         | string     | null: false                    |
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase_record


## purchase_records

| Column | Type       | Options                        |
| -------| ------     | --------------------------- -- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addresses

| Column          | Type       | Options                        |
| --------------- | ---------- | ---------------------------    |
| postal_code     | string     | null: false                    |
| province        | string     | null: false                    |
| city            | string     | null: false                    |
| street_address  | string     | null: false                    |
| building_name   | string     | null: false                    |
| phone_number    | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association
- belongs_to :purchase_record -->