class Chatroom < ActiveRecord::Base

  has_many :messages, dependent: :destroy

  def timed_destroy
    if (Time.now.hour - self.created_at.hour).abs >= 24
      self.destroy
    end
  end

end