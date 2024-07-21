class ZipCodesController < ApplicationController
  before_action :fetch_address_info, only: :search

  def index
    @address_info = nil
  end

  def search
    respond_to do |format|
      format.turbo_stream
      format.html { render :index }
    end
  end

  private

  def fetch_address_info
    zip_code = params[:cep]

    response = Faraday.get("https://cep.awesomeapi.com.br/json/#{zip_code}")

    @address_info = JSON.parse(response.body, symbolize_names: true)
    @address_info[:status] = response.status
  end
end
