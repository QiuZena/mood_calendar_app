# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  def create
    @diary_entry = DiaryEntry.find(params[:diary_entry_id])
    @diary_entry.comments.create(content: params[:content], user: current_user)
    redirect_back fallback_location: root_path
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy if comment.user == current_user
    redirect_back fallback_location: root_path
  end
end
