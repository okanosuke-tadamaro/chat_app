class MessagesController < ApplicationController

  before_action :current_user

  def create
    @chatroom = Chatroom.find_by(name: params[:room_name])
    # emotion = params[:content].scan(/(#\w*)/).flatten.first
    message = @chatroom.messages.create(content: params[:content], user_id: current_user.id)
    return_data = {obj: message, user: current_user.username}
    respond_to do |format|
      format.html { redirect_to "/chatrooms/#{@chatroom.name}" }
      format.json { render json: return_data.to_json }
    end
  end

end
