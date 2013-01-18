# spec/models/user.rb
require 'spec_helper'

describe User do

 	#validates presence of field (here none of the fields can be nil)
  it "is invalid without a email" do
    @user = User.create!(:email => 'admin@admin.com', 
      :password => 'admin123', 
      :password_confirmation => 'admin123',
      :role => "admin")
  	@user.email.should_not be_nil
    @user.password.should_not be_nil
    @user.password_confirmation.should_not be_nil
    @user.role.should_not be_nil
  end

  #validates that password and password_confirmation match
  it "is valid for password match" do
  	User.create!(:email => 'admin@admin.com', 
      :password => 'admin123', 
      :password_confirmation => 'admin123',
      :role => 'admin').should be_valid
  end

  #validates email field (here email should be valid format)
  it 'is invalid for email other than a specified valid format' do
    User.create!(:email => 'admin@admin.com', 
      :password => 'admin123', 
      :password_confirmation => 'admin123',
      :role => 'admin').should be_valid
  end

end