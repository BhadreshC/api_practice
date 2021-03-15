class ApplicationController < ActionController::Base
  puts "-----------application controller call-----------"
  def client
    @client ||= Hackernews::Client.new
  end
end