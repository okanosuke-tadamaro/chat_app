class Chatroom < ActiveRecord::Base

  has_many :messages, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  after_create :convert_name

  def convert_name
    self.update(name: self.name.gsub(/\s+/,"_"))
    self.update(name: self.name.gsub(",","_"))
    self.update(name: self.name.gsub(/"/,"'"))
  end

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
