require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/test.png')
  end

  describe '商品出品機能' do
    context '出品できるとき' do
      it 'image、name、detail、category_id、condition_id、postage_id、sender_id、shipment_id、priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが40文字を超えると登録できない' do
        @item.name = Faker::Name.initials(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end

      it 'detailが空では登録できない' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end
      it 'detailが1000文字を超えると登録できない' do
        @item.detail = Faker::Name.initials(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('Detail is too long (maximum is 1000 characters)')
      end

      it 'category_idが空では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが空では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'postage_idが空では登録できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it 'sender_idが空では登録できない' do
        @item.sender_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Sender can't be blank")
      end

      it 'shipment_idが空では登録できない' do
        @item.shipment_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipment can't be blank")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが9,999,999を超えると登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'priceが全角英字を含む場合は登録できない' do
        @item.price = '100O'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角英字を含む場合は登録できない' do
        @item.price = '100o'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが全角数字を含む場合は登録できない' do
        @item.price = '100０'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが記号を含む場合は登録できない' do
        @item.price = '100○'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが漢字を含む場合は登録できない' do
        @item.price = '1000円'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceがひらがなを含む場合は登録できない' do
        @item.price = '1000えん'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceがカタカナを含む場合は登録できない' do
        @item.price = '1000エン'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが半角ｶﾅを含む場合は登録できない' do
        @item.price = '1000ｴﾝ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
    end
  end
end
