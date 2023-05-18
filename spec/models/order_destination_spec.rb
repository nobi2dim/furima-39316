require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '商品購入機能' do
    before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id)
    sleep 0.1
    end

    context '購入できるとき' do
      it 'post_code、sender_id、city、block、building、phone_number,tokenが存在すれば購入できる' do
        expect(@order_destination).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '購入できないとき' do
      it 'post_codeが空では登録できない' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_destination.post_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'sender_idが空では購入できない' do
        @order_destination.sender_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Sender can't be blank")
      end

      it 'cityが空では購入できない' do
        @order_destination.city = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it 'blockが空では購入できない' do
        @order_destination.block = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Block can't be blank")
      end

      it 'phone_numberが空では購入できない' do
        @order_destination.phone_number = ""
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは10桁以上でないと購入できない' do
        @order_destination.phone_number = '123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberは11桁以下でないと購入できない' do
        @order_destination.phone_number = '123456789101'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberは記号が含まれていると購入できない' do
        @order_destination.phone_number = '1234-567-8910'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberは全角数字が含まれていると購入できない' do
        @order_destination.phone_number = '１２３４５６７８９１０'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid.')
      end


      it 'userが紐付いていないと購入できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと購入できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では購入できない" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
