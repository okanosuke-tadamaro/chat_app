class ChatroomsController < ApplicationController

  before_action :current_user

  def index
    begin
      @chatroom = Chatroom.new

      #AJAX request for rooms participated in
      rooms_ids = current_user.messages.pluck(:chatroom_id).uniq.sort!
      rooms = rooms_ids.map { |id| Chatroom.find(id) }
      @recent_rooms = {}
      rooms.each do |room|
        @recent_rooms[room.name] = room.how_old?
      end
      updated_rooms = @recent_rooms.map do |room_name, time_left|
        new_array = []
        new_array.push(room_name, time_left)
      end

      #Grabbing current user's Avatars from S3
      @avatars = User.get_avatars(current_user.username)
    rescue
      redirect_to register_path
    end

    respond_to do |format|
      format.html { render 'index'}
      format.json { render json: updated_rooms.to_json }
    end
  end

  def search
    room_name = params[:search].gsub(/\s+/,"_").gsub(",","_").gsub(/"/,"'").gsub(".","(dot)")
    @chatroom = Chatroom.find_by(name: room_name)
    if @chatroom
      redirect_to "/chatrooms/#{@chatroom.name}"
    else
      redirect_to chatrooms_path, notice: "Room: '#{params[:search]}' doesn't seem to exist - try creating it!"
    end
  end

  def create
    @chatroom = Chatroom.create(chatroom_params)
    if @chatroom.save
      redirect_to "/chatrooms/#{@chatroom.name}"
    else
      redirect_to chatrooms_path, notice: "Room: '#{@chatroom.name}' already exists - try searching for it!"
    end
  end

  def show
    begin
      @avatars = User.get_avatars(current_user.username)
      @chatroom = Chatroom.find_by(name: params[:name])
      @messages = @chatroom.messages.order(created_at: :desc)
    rescue
      redirect_to chatrooms_patb
    end
  end

  def get_messages
    chatroom = Chatroom.find_by(name: params[:name])
    messages = chatroom.messages.order(id: :desc)

    #AJAX request for user message ranking system in a chatroom
    users = []
    messages.each { |msg| users << msg.user.username }
    users = users.uniq
    user_msg_count = users.map do |usr|
      User.find_by(username: usr).messages.where(chatroom_id: chatroom.id).size
    end
    ranking_data = users.zip(user_msg_count)

    #AJAX request for new messages in chatroom - need to fix by ID instead of time value
    new_msgs = []
    messages.each do |msg|
      if msg.id > params[:msg_id].to_i && msg.user.username != current_user.username
        new_msgs << { message: msg, avt: msg.user.get_avatar(msg.emotion).read, msg_id: msg.id }
      end
    end

    #Returned AJAX object
    return_data = {
      user: current_user.username,
      rankings: ranking_data,
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
