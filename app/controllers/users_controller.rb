class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
#    @user = User.find(params[:id])
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
  end

  def show  
    p params[:id]
    @user = User.find(params[:id])
    p params[:id]    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
#    rescue ActiveRecord::RecordNotFound
#    flash[:notice] = "Wrong user id"
#    redirect_to :action => 'index'
  end

  def create
  end

  def update
  end

  def destroy
  end

end