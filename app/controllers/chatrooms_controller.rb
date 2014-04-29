class ChatroomsController < ApplicationController

  def index
    @chatroom = Chatroom.new()
  end

  def search
    @chatroom = params[:search]
    # if params[:search]
    #   @chatroom = Chatroom.search(params[:search])
    #   redirect_to chatroom_path(@chatroom)
    # else
    #   @chatroom = Chatroom.all.order('created_at DESC')
    # end
  end

  def create
    @chatroom = Chatroom.create(chatroom_params)
    redirect_to "/chatrooms/#{@chatroom.name}"
  end

  def show
    if
     @chatroom = Chatroom.find_by(name: params[:name])
    else
    @chatroom = Chatroom.find_by(name: params[:search])
    end
  end

  private
  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
