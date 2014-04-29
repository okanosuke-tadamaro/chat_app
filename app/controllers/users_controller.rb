class UsersController < ApplicationController

	def register
		
	end

	def create_avatar
		s3 = AWS::S3.new(:access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
		bucket = s3.buckets['s3-sample-pt']
	
		data = params[:file]
		file_name = "#{current_user.username}_#{params[:emotion]}.png"
		bucket.objects.create(file_name, data)

		return_data = {file: data, emotion: params[:emotion]}
		respond_to do |format|
			format.json { render json: return_data.to_json }
		end
	end

end
