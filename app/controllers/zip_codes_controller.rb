class ZipCodesController < ApplicationController
  def index
    @address_info = nil
  end

  def search
    zip_code = params[:cep]

    response = Faraday.get("https://cep.awesomeapi.com.br/json/#{zip_code}")

    @address_info = JSON.parse(response.body, symbolize_names: true)
    @address_info[:status] = response.status

    respond_to do |format|
      format.turbo_stream
      format.html { render :index }
    end
  end

end