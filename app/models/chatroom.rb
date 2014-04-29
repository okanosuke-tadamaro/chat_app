class Chatroom < ActiveRecord::Base

  has_many :messages, dependent: :destroy

  def timed_destroy
    if (Time.now.hour - self.created_at.hour).abs >= 24
      self.destroy
    end
  end

  def self.search(query)
    where("name like ?", "%#{query}%")
    # search_condition = "%" + search + "%"
    # find(:all, :conditions => ['name LIKE ?', search_condition])
  end

end
