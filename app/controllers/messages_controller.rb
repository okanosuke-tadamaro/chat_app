class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find params[:chatroom_id]
    # @message.user = current_user
    @message = @chatroom.messages.create message_params
    respond_to do |format|
      format.html { redirect_to @chatroom }
      format.js { }
      format.json { render json: @message.to_json }
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :created_at, :updated_at, :chatroom_id, :user_id)
  end

end
