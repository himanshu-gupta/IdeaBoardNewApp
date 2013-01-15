class UsersController < ApplicationController

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def show  
    p params[:id]
    @user = User.find(params[:id])
    p params[:id]    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Bingo!!! User created successfully.'}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { 
          flash[:error] = 'Fields can not be left blank.'
          render action: "new"
        }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User updated successfully.'}
        format.json { head :no_content }
      else
        format.html { 
          flash[:error] = 'Fields can not be left blank.'
          render action: "edit" 
         }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = 'User deleted successfully .'
        redirect_to users_url
      }
      format.json { head :no_content }
    end
  end

end