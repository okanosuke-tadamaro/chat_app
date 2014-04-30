class UsersController < ApplicationController

	before_action :current_user, only: [:create_avatar]

	def register

	end

	def create_avatar
		s3 =  User.new_aws_request
		bucket = s3.buckets['s3-sample-pt']
		data = params[:file]
		file_name = "#{current_user.username}_#{params[:emotion]}.png"
		bucket.objects.create(file_name, data, :acl => :public_read)
		return_data = {file: data, emotion: params[:emotion]}

		respond_to do |format|
			format.json { render json: return_data.to_json }
		end
	end

end
