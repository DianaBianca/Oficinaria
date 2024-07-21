class ZipCodesController < ApplicationController
  def search;end

  def result
    binding.pry
    cep = 12513415# params[:cep]

    response = Faraday.get("https://cep.awesomeapi.com.br/json/#{cep}")

    json = JSON.parse(response.body, symbolize_names: true)
    
  end

end