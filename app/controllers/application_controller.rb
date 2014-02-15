class ApplicationController < ActionController::Base
  
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper

	def signed_in_user
		redirect_to signin_url, flash: { info: "Veuillez vous connecter d'abord" } unless signed_in?
	end
end
