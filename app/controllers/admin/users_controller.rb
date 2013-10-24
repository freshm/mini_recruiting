class Admin::UsersController < ApplicationController
  before_filter :verify_admin
  # GET /users
  # GET /users.json
  def index
    @users = User.order('type asc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.email = params[:user][:email]

    respond_to do |format|
      if params[:user][:password] == ""
        if @user.save(validation: false)
          format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password]
        if @user.save
          format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end          
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_root_path }
      format.json { head :no_content }
    end
  end

  def promote_to_moderator
    @user = User.find(params[:id])
    @user.type = "Moderator"
    @user.save!
    redirect_to admin_root_path, notice: "#{@user.fullname} was granted Moderator privileges."
  end

  def demote_to_applicant
    @user = User.find(params[:id])
    @user.type = "Applicant"
    @user.save!
    redirect_to admin_root_path, notice: "#{@user.fullname} Moderator privileges were withdrawn."
  end
end
