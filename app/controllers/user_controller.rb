get '/' do
	@msg = params[:action]
	if logged_in?
		@user = current_user
		@surfer = current_user
		@statuses = current_user.statuses
		erb :"users/profile"
	else
  		erb :"users/home"
  	end
end


get '/users/:id' do
	@user = User.find_by(id: params[:id])
	if @user.nil?
		@msg = "Page not found"
		redirect "/?action=#{@msg}"
	else
	@surfer = current_user
	@statuses = Status.where(user_id: params[:id])
	erb :"users/profile"
	end

end

get '/users/home' do
	erb :"users/home"
end

get '/signup' do
	erb :"users/signup"
end

get '/login' do
	erb :"users/login"
end

# get '/users/:id' do
# 	if !logged_in?
# 		@msg = "Please Login First"
# 		redirect "/users/login"
# 	else
# 	@current_user = current_user
# 	@user = User.find_by(id: params[:id])
# 	erb :"users/profile"
# 	end
# end

post '/logout' do
	session.clear
	@msg = "Successfully logout"
	redirect "/?action=#{@msg}"
end


post '/signup' do
	@user = User.new(name: params[:name],user_email: params[:user_email], password: params[:user_password])
	if @user.save
		@msg = "Signup Successful, Login Nao!"
		redirect "/?action=#{@msg}"
	else	
		@msg = "Error"
		redirect "/?action=#{@msg}"
	end
end

post '/login' do
	@user = User.find_by(user_email: params[:user_email]).try(:authenticate, params[:user_password])
		if @user != nil
			session[:id] = @user.id
			@msg = "Login Successful"
			redirect "/?action=#{@msg}"
		else
			@msg = "Login Error"
			redirect "/?action=#{@msg}"
		end

end

post '/status' do
	@status = current_user.statuses.new(content: params[:content], user_id: current_user.id)
	if @status.save
		@msg = "Status posted"
		redirect "/?action=#{@msg}"
	else
		@msg = "Error"
		redirect "/?action=#{@msg}"
	end
end

delete "/status/:id" do
	@status = Status.find_by(id: params[:id])
	@status.destroy
	@msg = "Status Deleted"
	redirect "/?action=#{@msg}"	

end

put "/status/:id" do
	@status = Status.find_by(id: params[:id])
	@status.update(content: params[:content])
	@msg = "Status edited"
	redirect "/?action=#{@msg}"

end

get "/status/:id/edit" do
	@surfer = current_user
	@user = current_user
	@to_edit = params[:id]
	erb :"users/edit"

end


