require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できる場合' do
      it '全ての項目が入力されている' do
        expect(@item).to be_valid
      end

      it 'カテゴリーが---以外になっている' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end

      it '商品の状態が---以外になっている' do
        @item.status_id = '2'
        expect(@item).to be_valid
      end

      it '配送料の負担が---以外になっている' do
        @item.postage_id = '2'
        expect(@item).to be_valid
      end

      it '発送元の地域が---以外になっている' do
        @item.region_id = '2'
        expect(@item).to be_valid
      end

      it '発送までの日数が---以外になっている' do
        @item.shipping_date_id = '2'
        expect(@item).to be_valid
      end

      it '販売価格が300円から9999999円の間の半角数字で入力されている' do
        @item.price = '300'
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it '商品画像が選択されていない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が入力されていない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が入力されていない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが---になっている' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が---になっている' do
        @item.status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担が---になっている' do
        @item.postage_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it '発送元の地域が---になっている' do
        @item.region_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Region can't be blank")
      end

      it '発送までの日数が---になっている' do
        @item.shipping_date_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end

      it '販売価格が入力されていない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '販売価格が全角数字で入力されている' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '販売価格が数字以外で入力されている' do
        @item.price = '三百'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '販売価格が299円以下になっている' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end

      it '販売価格が10000000円以上になっている' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is out of setting range')
      end
    end
  end
end
