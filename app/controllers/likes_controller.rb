class LikesController < ApplicationController
  def create
    @diary_entry = DiaryEntry.find(params[:diary_entry_id])
    @diary_entry.likes.create(user: current_user)
    redirect_back fallback_location: root_path
  end

  def destroy
    @diary_entry = DiaryEntry.find(params[:diary_entry_id])
    like = @diary_entry.likes.find_by(user: current_user)
    like.destroy if like
    redirect_back fallback_location: root_path
  end
end