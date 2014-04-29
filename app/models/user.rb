class User < ActiveRecord::Base

  validates_presence_of :username, :token
  validates_uniqueness_of :username, :token

end
