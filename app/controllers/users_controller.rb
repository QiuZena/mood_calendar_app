class UsersController < ApplicationController
  before_action :authenticate_user!
  

  def index
  end

  def new
  end

  def create
  end


  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
  before_action :authenticate_user!

  def profile
    @user = current_user
    @entries = @user.diary_entries.order(entry_date: :desc).includes(:mood, image_attachment: :blob)
    @days_count = @entries.select(:entry_date).distinct.count
  end

  

end
