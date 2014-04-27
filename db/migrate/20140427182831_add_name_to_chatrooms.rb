class AddNameToChatrooms < ActiveRecord::Migration
  def change
    add_column :chatrooms, :name, :string
  end
end
