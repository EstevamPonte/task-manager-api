require 'rails_helper'

RSpec.describe Authenticable do
  controller(ApplicationController) do
    include Authenticable
  end

  let(:app_contoller) { subject }

  describe '#current_user' do
    let(:user) { create(:user) }

    before do
      req = double(:headers => { 'Authorization' => user.auth_token } )
      allow(app_contoller).to receive(:request).and_return(req)
    end

    it 'returns the user from the authorization header' do
      expect(app_contoller.current_user).to eq(user)
    end

  end
end