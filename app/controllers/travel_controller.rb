class TravelController < ApplicationController
  require 'uri'
  def index
  end

  def search
    countries = find_country(params[:country])
    unless countries
      flash[:alert] = 'Country not found'
      return render action: :index
    end
    @country = countries.first
    # @weather = find_weather(@country['capital'], @country['alpha2Code'])
    puts "------------------------"
    puts @country['capital']
    puts @country['alpha2Code']
    puts "------------------------"
  end

  private
  def request_api(url)
    puts "--------fetching api key------------"
    puts "--------fetching api key------------"
    puts ENV.fetch('RAPIDAPI_API_KEY')
    puts "--------fetching api key------------"
    puts "--------fetching api key------------"

    
    response = Excon.get(
      url,
      headers: {
        'X-RapidAPI-Host' => URI.parse(url).host,
        'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
      }
    )
    puts "----------------------"
    puts "--------response body--------------"
    puts response.headers
    puts response.body
    puts response.remote_ip
    puts "----------------------"
    puts "_____url_____"
    puts url.as_json
    puts "_____url_____"
    puts "------------------response--------------------------------------"
    puts response.as_json
    puts "------------------response--------------------------------------"
    return nil if response.status != 200
    JSON.parse(response.body)
  end
  def find_country(name)
    request_api(
      "https://restcountries-v1.p.rapidapi.com/name/#{URI.encode(name)}"
    )
  end
  def find_weather(city, country_code)
    puts "--------Find weather call----------"
    query = URI.encode("#{city},#{country_code}")
    request_api(
      "https://community-open-weather-map.p.rapidapi.com/forecast?q=#{query}"
    )
    puts "-00000000000000000000000D"
    puts "-00000000000000000000000D"
    puts query.as_json
    puts "-00000000000000000000000D"
    puts "-00000000000000000000000D"
    puts "-00000000000000000000000D"

  end
end
