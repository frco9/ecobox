require 'spec_helper'

describe User do

	before { @user = User.new(name: "Lapoire", firstname: "Denis", email: "user@example.fr") }
	
	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:firstname) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
end
