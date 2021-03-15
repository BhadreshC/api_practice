class StoriesController < ApplicationController
  def top
    @client ||= Hackernews::Client.new
    @start = (params[:start] || 0).to_i
    @per_page = (params[:per_page] || 10).to_i
    @per_page = [@per_page, 20].min # max 20 per page

    @stories = @client.topstories(@start, @per_page)

    # puts @client.as_json
    # puts "-----------StoriesController top method call---------------"
    # @stories = @client.topstories(0, 10)
    # puts @stories.as_json
    # puts "--------------------------"
  end

  def show
    @client ||= Hackernews::Client.new
    # get("item/#{params[:id]}")
    # puts params[:id]
    @story = @client.item(params[:id])
    puts "-----show--------"
    puts @story.as_json
    puts "-------------"
    @comments = (@story['kids'] || []).map do |comment|
    @client.item(comment)
    end
  end
end