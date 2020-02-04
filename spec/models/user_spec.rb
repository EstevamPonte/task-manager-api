require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) } # sera criado somente se alguem chamar o 'user'. Caso queira criar a força, deve ser adicionado '!' na frente do 'let'
  #UTILIZANDO A GEM 'shoulda-matchers'

  it { is_expected.to have_many(:tasks).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) } # verifica se a emails iguais
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('costa@nonato.com').for(:email)}
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email, created_at and a Token' do
      user.save! # Com o '!' o user.save ira tentar salvar, caso não consiga salvar é gerado uma exeção, sem o '!' a exeção não é gerada
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end

  describe '#generate_authentication_token!' do # O '!' na frente do metodo significa que algum atributo sera alterado, que ira gerar uma mudança no estado do atributo 'auth_token'
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xyzTOKEN')
    end

    it 'generate another auth token when the current auth token already has been take' do
      allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz','abcXYZ123456789')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
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
