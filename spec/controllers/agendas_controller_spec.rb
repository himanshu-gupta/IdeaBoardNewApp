require 'spec_helper'

# Reference site for rspec
# https://www.relishapp.com/rspec/rspec-expectations/v/2-0/docs

describe AgendasController do

  def valid_attributes
    { 
      :title => "Himanshu",
      :owner => nil
    }
  end

  def valid_session
    {
      :email => 'admin@admin.com',
      :password => 'admin123'
    }
  end

  def http_login
    user = 'admin@admin.com'
    pw = 'admin123'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end 

  describe "GET index" do
    it "assigns all agendas as @agendas" do
      agenda = Agenda.create! valid_attributes
      # invoking the action before assiging
      get :index, {}#, valid_session
      assigns(:agendas).should eq([agenda])
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
    it "assigns the requested agenda as @agenda" do
      agenda = Agenda.create! valid_attributes
      get :show, {:id => agenda.to_param}#, valid_session
      assigns(:agenda).should eq(agenda)
    end
  end

  describe "GET new" do
    it "assigns a new agenda as @agenda" do
      get :new, {}#, valid_session
      assigns(:agenda).should be_a_new(Agenda)
    end
  end

  describe "GET edit" do
    it "assigns the requested agenda as @agenda" do
      agenda = Agenda.create! valid_attributes
      get :edit, {:id => agenda.to_param}#, valid_session
      assigns(:agenda).should eq(agenda)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new agenda" do
        # expect{Counter.increment}.to change{Counter.count}.from(0).to(1)
        # expect{Counter.increment}.to change{Counter.count}.by(2)
        expect {
          post :create, {:agenda => valid_attributes}#, valid_session
        }.to change(Agenda, :count).by(1)
      end

      it "assigns a newly created agenda as @agenda" do
        post :create, {:agenda => valid_attributes}#, valid_session
        assigns(:agenda).should be_a(Agenda)
        assigns(:agenda).should be_persisted
      end

      it "redirects to the created agenda" do
        post :create, {:agenda => valid_attributes}#, valid_session
        response.should redirect_to(Agenda.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved agenda as @agenda" do
        # Trigger the behavior that occurs when invalid params are submitted
        Agenda.any_instance.stub(:save).and_return(false)
        post :create, {:agenda => { "title" => "invalid value" }}#, valid_session
        assigns(:agenda).should be_a_new(Agenda)
      end

      #validating render action
      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        # About stubs
        # https://relishapp.com/rspec/rspec-mocks/v/2-12/docs/method-stubs
        Agenda.any_instance.stub(:save).and_return(false)
        post :create, {:agenda => { "title" => "invalid value" }}#, valid_session
        response.should render_template("new")
      end
    end
  end

  before do
    @user = User.create!({
      :email => 'admin@admin.com',
      :password => 'admin123',
      :password_confirmation => 'admin123' 
    })
    sign_in @user
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested agenda" do
        agenda = Agenda.create! valid_attributes
        p agenda
        # Assuming there are no other agendas in the database, this
        # specifies that the Agenda created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.

        # agenda.update_attribute(:title, "MyString")
        Agenda.any_instance.should_receive(:update_attributes).with({ "title" => "MyString" })
        put :update, {:id => agenda.to_param, :agenda => { "title" => "MyString" }}#, valid_session
      end

      it "assigns the requested agenda as @agenda" do
        agenda = Agenda.create! valid_attributes
        put :update, {:id => agenda.to_param, :agenda => valid_attributes}#, valid_session
        assigns(:agenda).should eq(agenda)  
      end

      it "redirects to the agenda" do
        agenda = Agenda.create! valid_attributes
        put :update, {:id => agenda.to_param, :agenda => valid_attributes}#, valid_session
        response.should redirect_to(agenda)
      end
    end

    describe "with invalid params" do
      it "assigns the agenda as @agenda" do
        agenda = Agenda.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Agenda.any_instance.stub(:save).and_return(false)
        put :update, {:id => agenda.to_param, :agenda => { "title" => "invalid value" }}#, valid_session
        assigns(:agenda).should eq(agenda)
      end

      it "re-renders the 'edit' template" do
        agenda = Agenda.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Agenda.any_instance.stub(:save).and_return(false)
        put :update, {:id => agenda.to_param, :agenda => { "title" => "invalid value" }}#, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested agenda" do
      agenda = Agenda.create! valid_attributes
      expect {
        delete :destroy, {:id => agenda.to_param}#, valid_session
      }.to change(Agenda, :count).by(-1)
    end

    it "redirects to the agendas list" do
      agenda = Agenda.create! valid_attributes
      delete :destroy, {:id => agenda.to_param}#, valid_session
      response.should redirect_to(agendas_url)
    end
  end

end
