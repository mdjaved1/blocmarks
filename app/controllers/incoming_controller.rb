class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "INCOMING PARAMS HERE: #{params}"
    @user =  User.find_by(email: params["sender"])
    @topic = Topic.find_by(title: params["subject"])
    p @user
    p @topic
    p params["body-plain"]
    @url = params["body-plain"]

    if @user.nil?
      puts "created user"
      @user = User.create(email: params["sender"], password: '123')
    end

    if @topic.nil?
      @topic = Topic.create(title: params["subject"], user: @user)
    end

    @bookmark = @topic.bookmarks.create(url: @url)

    head 200
   
  end
end

