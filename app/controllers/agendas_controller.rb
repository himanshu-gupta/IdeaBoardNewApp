class AgendasController < ApplicationController

# http_basic_authenticate_with :name => "admin@admin.com", :password => "admin123", :only => [:destroy, :update]
  before_filter :authenticate_user!, :only => [:update, :destroy]
  
  # GET /agendas
  # GET /agendas.json
  def index
    @agendas = Agenda.order("agendas.created_at DESC").page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agendas }
      format.xls
    end
  end

  def my_topics
    @agendas = Agenda.where(:user_id => current_user.id).order("agendas.created_at DESC").page(params[:page]).per(10)
    respond_to do |format|
      format.html { render :template => "agendas/index"}
    end
  end

  def popular_topics
    @agendas = Agenda.order("agendas.ideas_count DESC").page(params[:page]).per(10)
    respond_to do |format|
      format.html { render :template => "agendas/index"}
    end
  end

  # GET /agendas/1
  # GET /agendas/1.json
  def show
    @agenda = Agenda.find(params[:id])
    @ideas= @agenda.ideas #.where("")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agenda }
      format.xls
    end
  end

  # GET /agendas/new
  # GET /agendas/new.json
  def new
    @agenda = Agenda.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agenda }
    end
  end

  # GET /agendas/1/edit
  def edit
    @agenda = Agenda.find(params[:id])
  end

  # POST /agendas
  # POST /agendas.json
  def create
    @agenda = Agenda.new(params[:agenda])
    @agenda.user_id = current_user.id if current_user.present?
    respond_to do |format|
      if @agenda.save
        format.html { redirect_to @agenda, notice: 'Congratulations!!! Topic created successfully.'}
        format.json { render json: @agenda, status: :created, location: @agenda }
      else
        format.html { 
          flash[:error] = 'Title field can not be left blank.'
          render action: "new"
        }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /agendas/1
  # PUT /agendas/1.json
  def update
    @agenda = Agenda.find(params[:id])
    respond_to do |format|
      if @agenda.update_attributes(params[:agenda])
        format.html { redirect_to @agenda, notice: 'Topic updated successfully.'}
        format.json { head :no_content }
      else
        format.html { 
          flash[:error] = 'Title field can not be left blank.'
          render action: "edit" 
         }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.json
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.destroy
    respond_to do |format|
      format.js
    end
  end

end