  class TravelController < ApplicationController
    def index
    end

    def search
      @host = find_hostname(params[:hostname])
      puts "-0------------"
      puts params[:hostname]
      puts "-0------------"
      unless @host
        flash[:alert] = 'Country not found'
        return render action: :index
      end
      puts "----------------------"
      puts "----------host_detail------------"
      puts @host.as_json
      puts "----------------------"
      puts "----------------------"
      if !params[:country].blank?
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
    end

    def view
      url = URI("http://localhost:3000")
      http = Net::HTTP.new(url.host, url.port)
      puts "-----===================----------"
      puts http.as_json 
      puts "-----===================----------"
      puts "-----------------"
      puts "-----------------"
      @url = "https://vaccovid-coronavirus-vaccine-and-treatment-tracker.p.rapidapi.com/api/npm-covid-data/world"
      response = Excon.get(
        @url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(@url).host,
          'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
        }
      )
      puts headers.as_json
      return nil if response.status != 200
      JSON.parse(response.body)
      @data = JSON.parse(response.body).first
      puts "----------view method api response----------------"
      puts @data
      puts "----------view method api response----------------"
    end

    def message
      if !params[:category].blank?
        @url = "https://ajith-messages.p.rapidapi.com/getMsgs?category=#{params[:category]}"
        response = Excon.get(
          @url, 
          headers: {
          'X-RapidAPI-Host' => URI.parse(@url).host,
          'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
          }
        )
        return nil if response.status != 200
        JSON.parse(response.body)
        @msg = JSON.parse(response.body)
        puts "---------------------"
        puts @msg.as_json
        puts "---------------------"
        puts "---------------------"
      end
      puts "--------------------------------"
      puts "--------------------------------"
      puts "--------------------------------"
    end

    def match_schedule
      puts "------------"
      puts ENV['MATCH_SCHEDULE_API_KEY']
      puts "------------"
      @url = "https://cricapi.com/api/matchCalendar"
      response = Excon.get(
        @url,
        headers: {
          'apikey' => ENV['MATCH_SCHEDULE_API_KEY']
        }
      )
      return nil if response.status != 200
      JSON.parse(response.body)
      @matches = JSON.parse(response.body)
      puts "---------------------"
      @match= @matches['data'].to_a
      puts @match.as_json
      puts "---------------------"
      puts "---------------------"
    end

    private
    def request_api(url)
      puts "--------fetching api key------------"
      puts "--------fetching api key------------"
      puts ENV['RAPIDAPI_API_KEY']
      puts "--------fetching api keyy------------"
      puts "--------fetching api key------------"

      response = Excon.get(
        url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(url).host,
          'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
        }
      )
      puts "----------------------"
      puts URI.parse(url).host
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
    end

    def request_api_for_hotdetail(url)
      response = Excon.get(
        url,
        headers: {
          'X-RapidAPI-Host' => URI.parse(url).host,
          'X-RapidAPI-Key' => ENV['RAPIDAPI_API_KEY']
        }
      )
      return nil if response.status != 200
      JSON.parse(response.body)
    end

    def find_hostname(hostname)
      request_api_for_hotdetail("https://free-geo-ip.p.rapidapi.com/json/#{URI.encode(hostname)}")
    end
  end

  # used api link
  # https://rapidapi.com/ajith/api/messages
