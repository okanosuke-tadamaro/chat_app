class User < ActiveRecord::Base

  has_many :messages
  validates_presence_of :username, :token
  validates_uniqueness_of :username, :token

  def self.new_aws_request
    return AWS::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
  end

  def self.get_avatars(username)
    result = {}
    emotions = ["happy", "sad", "mad", "surprised", "rofl", "confused"]
    aws = User.new_aws_request
    bucket = aws.buckets['s3-sample-pt']

    emotions.each { |emotion| result[emotion] = bucket.objects["#{username}_#{emotion}.png"] }
    return result
  end

  def get_avatar(emotion)
    aws = User.new_aws_request
    bucket = aws.buckets['s3-sample-pt']
    return bucket.objects["#{self.username}_#{emotion}.png"]
  end

end
