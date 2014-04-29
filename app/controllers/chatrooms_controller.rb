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

    respond_to do |format|
      format.html { redirect_to "/chatrooms/#{@chatroom.name}" }
      format.json { render json: @chatroom.to_json }
    end
  end

  def show
    @chatroom = Chatroom.find_by(name: params[:name])
    @messages = @chatroom.messages.order(id: :desc)
  end

  private

  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
