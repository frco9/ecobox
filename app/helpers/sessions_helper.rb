module SessionsHelper


  # Creates a session for one user and a cookie to keep his token. This token is also hashed and stored in DB
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

  # Retrieves user matching openned session.
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token) 
	end

	def current_user?(user)
		user == current_user
	end

  # Destroys user cookie and session. Plus adds a new token in the DB for more security
	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

  # Store current url in session cache
	def store_location
		session[:return_to] = request.url if request.get?
	end

  # Redirects user to the "return_to" session variable if exists otherwise redirects to the given url
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
end
