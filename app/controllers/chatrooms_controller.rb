class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.create(name: params[:name])
    respond_to do |format|
      format.html { redirect_to(@chatroom) }
      format.js { }
      format.json { render json: @chatroom.to_json }
    end
  end

  def show
    @chatroom = Chatroom.find params[:id]
  end

  private
  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
