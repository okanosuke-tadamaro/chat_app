class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.create(chatroom_params)
    redirect_to(@chatroom)
  end

  def show
    @chatroom = Chatroom.find params[:id]
  end

  private
  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
