class MessagesController < ApplicationController

  def create
    @message = Message.create(message_params)
  end

  private
  def message_params
    return params[:message].permit(:content, :emotion)
  end

end
