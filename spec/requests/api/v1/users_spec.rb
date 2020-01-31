require 'rails_helper'

RSpec.describe 'Users API', type: :request do
    let!(:user) { create(:user) } # O 'create' cria um objeto e salva no banco de dados, o 'build' cria um objeto na memoria e não salva no bando de dados
    let(:user_id) { user.id }

    before{ host! 'api.taskmanager.test' }

    describe 'GET /users/:id' do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
            get "/users/#{user_id}", params: {}, headers: headers
        end

        context 'when the user exists' do
            it 'returns the user' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:id]).to eq(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the user does not exist' do
            let(:user_id) { 10000 }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end

    end

    describe 'POST /users' do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
            post '/users', params: { user: user_params }, headers: headers
        end

        context 'when the request params are valid' do
            let(:user_params) { attributes_for(:user) } # FactoryGirl.attributes_for(:user) ou attributes_for(:user)

            it 'return status code 201' do
                expect(response).to have_http_status(201)
            end

            it 'return json data for created user' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end

        context 'when the request params are invalid' do
            let(:user_params) { attributes_for(:user, email: 'invalid_email@') }
            
            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns the json data for the erros' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
        end
    end

    describe 'PUT /users/:id' do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.vi'}
            put "/users/#{user_id}", params: { user: user_params }, headers: headers
        end
        
        context 'when the request params are valid' do
            let(:user_params) { { email: 'new_email@taskmanager.com' } }
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the json data for the updated user' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response[:email]).to eq(user_params[:email])
            end
        end

        context 'when the request params are invalid' do
            let(:user_params) { { email: 'invalid_email@' } }

            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns the json data for the erros' do
                user_response = JSON.parse(response.body, symbolize_names: true)
                expect(user_response).to have_key(:errors)
            end
        end
    end

    describe 'DELETE /users/:id' do
        before do
            headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
            delete "/users/#{user_id}", params: {}, headers: headers
        end

        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end

        it "removes the user from database" do
            expect( User.find_by(id: user.id)).to be_nil
        end
    end
end