require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、passwordとpassword_confirmation、
        last_name、first_name、last_name_kana、first_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'email_test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'pass0'
        @user.password_confirmation = 'pass0'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end
      it 'passwordが半角英字のみの場合は登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '000000'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordは全角では登録できない' do
        @user.password = 'ｐａｓｓｗ0ｒｄ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'last_nameが全角英字を含む場合は登録できない' do
        @user.last_name = 'YAMADA'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'last_nameが半角英字を含む場合は登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'last_nameが全角数字を含む場合は登録できない' do
        @user.last_name = '０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'last_nameが半角数字を含む場合は登録できない' do
        @user.last_name = '000'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'last_nameが半角ｶﾅを含む場合は登録できない' do
        @user.last_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'last_nameが記号を含む場合は登録できない' do
        @user.last_name = '＃山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は不正な値です')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前を入力してください")
      end
      it 'first_nameが全角英字を含む場合は登録できない' do
        @user.first_name = 'TARO'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'first_nameが半角英字を含む場合は登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'first_nameが全角数字を含む場合は登録できない' do
        @user.first_name = '０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'first_nameが半角数字を含む場合は登録できない' do
        @user.first_name = '000'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'first_nameが半角ｶﾅを含む場合は登録できない' do
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end
      it 'first_nameが記号を含む場合は登録できない' do
        @user.first_name = '＃太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は不正な値です')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
      end
      it 'last_name_kanaが全角英字を含む場合は登録できない' do
        @user.last_name_kana = 'YAMADA'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが半角英字を含む場合は登録できない' do
        @user.last_name_kana = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが全角数字を含む場合は登録できない' do
        @user.last_name_kana = '０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが半角数字を含む場合は登録できない' do
        @user.last_name_kana = '000'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが半角ｶﾅを含む場合は登録できない' do
        @user.last_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが記号を含む場合は登録できない' do
        @user.last_name_kana = '＃ヤマダ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaが漢字を含む場合は登録できない' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end
      it 'last_name_kanaがひらがなを含む場合は登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字(カナ)は不正な値です')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(カナ)を入力してください")
      end
      it 'first_name_kanaが全角英字を含む場合は登録できない' do
        @user.first_name_kana = 'TARO'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが半角英字を含む場合は登録できない' do
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが全角数字を含む場合は登録できない' do
        @user.first_name_kana = '０００'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが半角数字を含む場合は登録できない' do
        @user.first_name_kana = '000'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが半角ｶﾅを含む場合は登録できない' do
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが記号を含む場合は登録できない' do
        @user.first_name_kana = '＃タロウ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaが漢字を含む場合は登録できない' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end
      it 'first_name_kanaがひらがなを含む場合は登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は不正な値です')
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
    end
  end
end
