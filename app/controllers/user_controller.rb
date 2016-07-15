get '/' do
	if logged_in?
		erb :"users/profile"
	else
  		erb :"users/home"
  	end
end

get '/signup' do
	erb :"users/signup"
end

get '/login' do
	erb :"users/login"
end

post '/logout' do
	session.clear
	@msg = "Successfully logout"
	redirect "/?action=#{@msg}"
end

post '/signup' do
	@user = User.new(name: params[:name],user_email: params[:user_email], password: params[:user_password])
	if @user.save
		@msg = "Signup Successful"
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




