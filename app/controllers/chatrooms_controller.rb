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
    @avatars = User.get_avatars(current_user.username)
    @chatroom = Chatroom.find_by(name: params[:name])
    @messages = @chatroom.messages.order(id: :desc)
  end

  def get_messages
    @chatroom = Chatroom.find_by(name: params[:name])
    @messages = @chatroom.messages.order(id: :desc)

    users = []
    @messages.each { |msg| users << msg.user.username }
    users = users.uniq
    user_msg_count = users.map { |usr| usr.messages.where(chatroom_id: @chatroom.id).size }
    ranking_data = users.zip(user_msg_count)
    # time = params[:timestamp].split[4].to_datetime
    # foo = @chatroom.messages.where(["created_at < ?", time])

    return_data = {messages: @messages, userName: current_user.username, ranking_data: ranking_data }

    respond_to do |format|
      format.json { render json: return_data.to_json }
    end
  end

  private

  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
