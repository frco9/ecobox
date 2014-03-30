module SessionsHelper

	# sign_in crée une session pour un utilisateur, en lui créant un cookie contenant sa valeur de jeton d'identification
	# et en stockant une version hachée de celui ci dans la base
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

	# current_user récupère l'utilisateur correspondant à la session courante
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token) 
	end

	def current_user?(user)
		user == current_user
	end

	# sign_out détruit le cookie contenant le jeton de l'utilisateur et termine la session,
	# attribution d'un nouveau jeton dans la base pour sécuriser d'avantage
	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	# store_location stocke l'url courante dans une variable de session
	def store_location
		session[:return_to] = request.url if request.get?
	end

	# redirect_back_or redirige l'utilisateur vers la variable de session si elle existe, sinon vers l'url en paramètre
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end
end
