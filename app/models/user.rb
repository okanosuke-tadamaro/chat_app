class User < ActiveRecord::Base

  validates :username, :token, presence: true, uniqueness: true

end
