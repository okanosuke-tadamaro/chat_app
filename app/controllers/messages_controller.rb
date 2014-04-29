class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find_by(name: params[:room_name])
    message = @chatroom.messages.create(content: params[:content], chatroom_id: @chatroom.id, user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to "/chatrooms/#{@chatroom.name}" }
      format.json { render json: message.to_json }
    end
  end

end
