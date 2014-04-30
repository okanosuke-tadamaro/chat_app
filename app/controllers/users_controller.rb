class UsersController < ApplicationController

	def register

	end

	def create_avatar
		s3 =  User.new_aws_request
		bucket = s3.buckets[ENV['S3_BUCKET_NAME']]
		bucket.acl = :public_read
		data = params[:file]
		file_name = "#{current_user.username}_#{params[:emotion]}.png"
		bucket.objects.create(file_name, data)
		p 
		return_data = {file: data, emotion: params[:emotion]}

		respond_to do |format|
			format.json { render json: return_data.to_json }
		end
	end

end
