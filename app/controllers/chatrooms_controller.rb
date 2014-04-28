class ChatroomsController < ApplicationController

  def show
    @chatroom = Chatroom.find_by(name: params[:room_name])
    @messages = @chatroom.messages.order(id: :desc)
  end

  def create
    @chatroom = Chatroom.create(name: params[:name])
    respond_to do |format|
      format.html { redirect_to "/chatrooms/#{@chatroom.name}" }
      format.json { render json: @chatroom.to_json }
    end
  end

  private
  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
