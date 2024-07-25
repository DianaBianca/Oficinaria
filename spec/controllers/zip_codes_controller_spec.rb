require 'rails_helper'
require 'faraday'
require 'webmock/rspec'

RSpec.describe ZipCodesController, type: :controller do

  shared_examples 'renders the search template' do
    it 'renders the search template' do
      subject
      expect(response).to render_template(:search)
    end
  end

  describe 'GET #index' do
    subject { get :index, format: :html }

    it 'assigns @address_info to nil' do
      subject
      expect(assigns(:address_info)).to be_nil
    end

    it 'renders the index template' do
      subject
      expect(response).to render_template(:index)
    end

    it 'assigns @most_searched_zip_code with the top 4 most searched zip codes' do
      zip_code_logs = [
        { zip_code: '01001-000', state: 'SP', city: 'São Paulo', district: 'Centro', search_count: 15 },
        { zip_code: '01002-000', state: 'SP', city: 'São Paulo', district: 'Liberdade', search_count: 22 },
        { zip_code: '01003-000', state: 'SP', city: 'São Paulo', district: 'Paulista', search_count: 10 },
        { zip_code: '02001-000', state: 'RJ', city: 'Rio de Janeiro', district: 'Centro', search_count: 30 },
        { zip_code: '02002-000', state: 'RJ', city: 'Rio de Janeiro', district: 'Copacabana', search_count: 25 }
      ]
      
      zip_code_logs.each do |log|
        ZipCodeLog.create!(log)
      end

      get :index, format: :html

      expect(assigns(:most_searched_zip_code).size).to eq(4)
      expect(assigns(:most_searched_zip_code).pluck(:search_count)).to match_array([30, 25, 22, 15])
    end
  end

  describe 'GET #search' do
    let(:zip_code) { '12513415' }
    let(:zip_code_incorrect) { '1251asd' }
    let(:zip_code_not_found) { '12513416' }

    let(:valid_response) do
      {
        "status": 200,
        "cep": "12513415",
        "address_type": "Rua",
        "address_name": "Augusto Lemes da Silva",
        "address": "Rua Augusto Lemes da Silva",
        "state": "SP",
        "district": "Residencial Village Santana",
        "lat": "-22.77127",
        "lng": "-45.19512",
        "city": "Guaratinguetá",
        "city_ibge": "3518404",
        "ddd": "12"
      }
    end

    let(:invalid_response) do
      {
        "status": 400,
        "code": "invalid",
        "message": "CEP invalido, tente: 00000000"
      }
    end

    let(:not_found_response) do
      {
        "status": 404,
        "code": "not_found",
        "message": "O CEP 12513416 nao foi encontrado"
      }
    end

    context 'when the requisition is valid' do
      before do
        stub_request(:get, "https://cep.awesomeapi.com.br/json/#{zip_code}")
          .to_return(status: 200, body: valid_response.to_json)

        get :search, params: { cep: zip_code }, format: :turbo_stream
      end

      it 'assigns @address_info' do
        expect(assigns(:address_info)).to eq(valid_response)
      end

      it 'saves or updats the zipcode log' do
        log = ZipCodeLog.find_by(zip_code:, state: valid_response[:state])
        expect(log).not_to be_nil
        expect(log.search_count).to eq(1)
      end

      include_examples 'renders the search template'
    end

    context 'when the requisition is invalid' do

      context 'with incorrect zip code' do
        before do
          stub_request(:get, "https://cep.awesomeapi.com.br/json/#{zip_code_incorrect}")
            .to_return(status: 400, body: invalid_response.to_json)

          get :search, params: { cep: zip_code_incorrect }, format: :turbo_stream
        end

        it 'assigns @address_info' do
          expect(assigns(:address_info)).to include("message": "CEP invalido, tente: 00000000")
        end

        include_examples 'renders the search template'
      end

      context 'with not foud zip code' do
        before do
          stub_request(:get, "https://cep.awesomeapi.com.br/json/#{zip_code_not_found}")
            .to_return(status: 404, body: not_found_response.to_json)

          get :search, params: { cep: zip_code_not_found }, format: :turbo_stream
        end

        it 'assigns @address_info' do
          expect(assigns(:address_info)).to include("message": "O CEP 12513416 nao foi encontrado")
        end

        include_examples 'renders the search template'
      end
    end
  end
end
