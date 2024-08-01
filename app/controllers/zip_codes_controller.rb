class ZipCodesController < ApplicationController
  before_action :fetch_address_info, only: :search

  def index
    @address_info = nil
    @most_searched_zip_codes = most_searched_zip_codes
  end

  def search
    @most_searched_zip_codes = most_searched_zip_codes
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

    save_zip_code_log if @address_info[:status] == 200
  end

  def save_zip_code_log
    log = ZipCodeLog.find_or_initialize_by(zip_code: @address_info[:cep], state: @address_info[:state], city: @address_info[:city], district: @address_info[:district])
    log.search_count = log.search_count + 1
    log.save!
  end

  def most_searched_zip_codes
    ZipCodeLog.order(search_count: :desc).limit(4)
  end
end
