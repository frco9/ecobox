class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper

	# signed_in_user saves the incomming url to redirect the user to it after beeing successfully logged-in
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, flash: { info: "Veuillez vous connecter d'abord" }
		end
	end
end
