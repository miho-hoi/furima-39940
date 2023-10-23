require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe "ユーザー新規登録" do
    context "ユーザー新規登録ができる場合" do
      it "全ての項目が入力されている" do
        expect(@user).to be_valid
      end 

      it "パスワードとパスワード(確認)が一致していて、６文字以上の半角英数字が混在している" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        expect(@user).to be_valid
      end

      it "お名前が全角で入力されている" do
        @user.family_name = '山田'
        @user.first_name = '陸太郎'
        expect(@user).to be_valid
      end

      it "お名前(カナ)が全角カタカナで入力されている" do
        @user.family_name_kana = "ヤマダ"
        @user.first_name_kana = "リクタロウ"
        expect(@user).to be_valid
      end
    end

    context "ユーザー新規登録ができない場合" do
      it "ニックネームが入力されていない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "メールアドレスが入力されていない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスが既存のものと重複している" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "メールアドレスに@が含まれていない" do
        @user.email = "testmail"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "パスワードが入力されていない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードが５文字以下である" do
        @user.password = "a1234"
        @user.password_confirmation = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードが英字のみで入力されている" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワードが数字のみで入力されている" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワードが全角で入力されている" do
        @user.password = "ａ１２３４５"
        @user.password_confirmation = "ａ１２３４５"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end

      it "パスワード(確認)が入力されていない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "パスワードとパスワード(確認)が一致していない" do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa1111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "お名前の苗字が入力されていない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it "お名前の苗字が全角で入力されていない" do
        @user.family_name = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid. Input full-width characters")
      end

      it "お名前の下の名前が入力されていない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "お名前の下の名前が全角で入力されていない" do
        @user.first_name= "rikutaro"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end

      it "お名前(カナ)の苗字が入力されていない" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it "お名前(カナ)の苗字が全角カタカナで入力されていない" do
        @user.family_name_kana = "山田"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid. Input full-width katakana characters")
      end

      it "お名前(カナ)の下の名前が入力されていない" do
        @user.first_name_kana= ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it "お名前(カナ)の下の名前が全角カタカナで入力されていない" do
        @user.first_name_kana = "陸太郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end

      it "生年月日が入力されていない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
