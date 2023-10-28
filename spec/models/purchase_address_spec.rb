require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @purchase_address = FactoryBot.build(:purchase_address)
  end

  describe '商品購入機能' do
    context '商品を購入できる場合' do
      it '全ての項目が正しく入力されている' do
        expect(@purchase_address).to be_valid
      end

      it '建物名は入力されていなくても購入できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
      
      it '郵便番号が半角数字の3桁-4桁で入力されている' do
        @purchase_address.postal_code = '111-1111'
        expect(@purchase_address).to be_valid
      end

      it '電話番号が10桁か11桁の半角数字で入力されている' do
        @purchase_address.phone_number = '0120111111'
      end
    end

    context '商品を購入できない場合' do
      it '郵便番号が入力されていない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号に-が含まれていない' do
        @purchase_address.postal_code = '1111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '郵便番号が3桁-4桁以外で入力されている' do
        @purchase_address.postal_code = '11-11111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '郵便番号が全角数字で入力されている' do
        @purchase_address.postal_code = '１１１-１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '郵便番号が数字以外で入力されている' do
        @purchase_address.postal_code = 'aaa-aaaa'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が---になっている' do
        @purchase_address.region_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Region can't be blank")
      end

      it '市区町村が入力されていない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が入力されていない' do
        @purchase_address.block = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Block can't be blank")
      end

      it '電話番号が入力されていない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下になっている' do
        @purchase_address.phone_number = '090111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid.")
      end

      it '電話番号が全角数字で入力されている' do
        @purchase_address.phone_number = '０９０１１１１１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid.")
      end

      it '電話番号が数字以外で入力されている' do
        @purchase_address.phone_number = 'ゼロキュウゼロイチイチイチイチイ'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number is invalid.")
      end
      
      it 'userが紐づいていなければ出品できない' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐づいていなければ出品できない' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
