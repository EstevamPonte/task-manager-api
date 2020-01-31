require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) } # sera criado somente se alguem chamar o 'user'. Caso queira criar a força, deve ser adicionado '!' na frente do 'let'
  #UTILIZANDO A GEM 'shoulda-matchers'
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive } # verifica se a emails iguais
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('costa@nonato.com').for(:email)}
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email and created_at' do
      user.save!

      expect(user.info).to eq("#{user.email} - #{user.created_at}")
    end
  end

  # context 'when name is blank' do
  #   before(:each) { user.name = ' ' }

  #   it { expect(user).not_to be_valid}
  # end
  
  # context 'when name is nil' do
  #   before(:each) { user.name = nil }

  #   it { expect(user).not_to be_valid}
  # end


  # before { @user = FactoryGirl.build(:user) }
  
  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation)}
  # it { expect(@user).to be_valid }
  
  # subject { build(:user) } 
  
  # it { expect(subject).to respond_to(:email) }
  # it { expect(subject).to respond_to(:name) }
  # it { expect(subject).to respond_to(:password) }
  # it { expect(subject).to respond_to(:password_confirmation)}
  # it { expect(subject).to be_valid }


  # # Ou

  # it { is_expected.to respond_to(:email)}
end
