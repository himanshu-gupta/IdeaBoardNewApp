require 'spec_helper'

# Reference site for rspec
# https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs

describe UsersController do

  def valid_attributes
    { 
      :email => "admin@admin.com",
      :password => 'admin123',
      :password_confirmation => 'admin123',
      :role => "admin"
    }
  end

  describe "GET index" do
    it "assigns all users as @users" do
      user = User.create! valid_attributes
      # invoking the action before assiging
      get :index, {}#, valid_session
      assigns(:users).should eq([user])
    end
  end

  # About to_param
  # to_param(namespace = nil) public
  # example:
  # {:name => 'David', :nationality => 'Danish'}.to_param
  # => "name=David&nationality=Danish"
  # {:name => 'David', :nationality => 'Danish'}.to_param('user')
  # => "user[name]=David&user[nationality]=Danish"
  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, {:id => user.to_param}#, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :edit, {:id => user.to_param}#, valid_session
      assigns(:user).should eq(user)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = User.create! valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.

        # user.update_attribute(:email, "MyString")
        User.any_instance.should_receive(:update_attributes).with({ "email" => "MyString" })
        put :update, {:id => user.to_param, :user => { "email" => "MyString" }}#, valid_session
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}#, valid_session
        assigns(:user).should eq(user)  
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}#, valid_session
        response.should redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}#, valid_session
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = User.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, {:id => user.to_param, :user => { "email" => "invalid value" }}#, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, {:id => user.to_param}#, valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete :destroy, {:id => user.to_param}#, valid_session
      response.should redirect_to(users_url)
    end
  end

end
