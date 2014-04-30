class ChatroomsController < ApplicationController

  before_action :current_user

  def index
    @chatroom = Chatroom.new
    rooms_ids = current_user.messages.pluck(:chatroom_id).uniq
    rooms = rooms_ids.map { |id| Chatroom.find(id) }
    @recent_rooms = {}
    rooms.each do |room|
      @recent_rooms[room.name] = "#{24 - (Time.now.hour + 4 - room.created_at.hour).abs} hours #{(Time.now.min - room.created_at.min).abs} minutes left"
    end
    updated_rooms = @recent_rooms.map do |room_name, time_left|
      new_array = []
      new_array.push(room_name, time_left)
    end

    @avatars = User.get_avatars(current_user.username)

    respond_to do |format|
      format.html { render 'index'}
      format.json { render json: updated_rooms.to_json }
    end
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
    @messages = @chatroom.messages.order(created_at: :desc)
  end

  def get_messages
    chatroom = Chatroom.find_by(name: params[:name])
    messages = chatroom.messages.order(created_at: :desc)

    users = []
    messages.each { |msg| users << msg.user.username }
    users = users.uniq
    user_msg_count = users.map do |usr|
      User.find_by(username: usr).messages.where(chatroom_id: chatroom.id).size
    end
    ranking_data = users.zip(user_msg_count)

    new_msgs = []
    messages.each do |msg|
      if msg.created_at.to_i >= (params[:timestamp].to_i / 1000 - 3) && msg.user.username != current_user.username
        new_msgs << msg
      end
    end

    return_data = {
      messages: messages,
      user: current_user.username,
      rankingData: ranking_data,
      newMsgs: new_msgs
    }

    respond_to do |format|
      format.json { render json: return_data.to_json }
    end
  end

  private

  def chatroom_params
    return params[:chatroom].permit(:name)
  end

end
