class DiaryEntriesController < ApplicationController
  def index
    # @diary_entries = DiaryEntry.all
    @current_month_entries = DiaryEntry.includes(:mood).where(entry_date: Date.today.beginning_of_month..Date.today.end_of_month)

    # @todays_entries = DiaryEntry.where(entry_date: Date.today).where.not(user_id: current_user.id)
    @todays_entries = DiaryEntry.includes(:user, :mood, image_attachment: :blob).where(entry_date: Date.today)

    @moods = Mood.all
  end

  def create
    # 找到今天是否已经有日记（按 user_id 和 entry_date 匹配）
    existing_entry = DiaryEntry.find_by(user_id: current_user.id, entry_date: Date.today)
  
    if existing_entry
      # 有则更新内容
      if existing_entry.update(diary_entry_params)
        redirect_to existing_entry, notice: "Today's mood entry has been updated."
      else
        render :new
      end
    else
      # 没有则新建
      @diary_entry = DiaryEntry.new(diary_entry_params)
      @diary_entry.user_id = current_user.id  # 确保绑定当前用户
      @diary_entry.entry_date = Date.today
  
      if @diary_entry.save
        redirect_to @diary_entry, notice: "Diary entry created."
      else
        render :new
      end
    end
  end
  

  def show
    @diary_entry = DiaryEntry.with_attached_image.find(params[:id])

    unless @diary_entry
      redirect_to diary_entries_path, alert: "Diary entry not found."
    end
  end
  

  def edit
    @diary_entry = DiaryEntry.find(params[:id])
  end

  def update
    @diary_entry = DiaryEntry.find(params[:id])
    if @diary_entry.update(diary_entry_params)
      redirect_to @diary_entry
    else
      render :edit
    end
  end

  def destroy
    @diary_entry = DiaryEntry.find(params[:id]) 
    @diary_entry.destroy
    redirect_to diary_entries_path
  end

  def new
    @diary_entry = DiaryEntry.new(entry_date: Date.today, user_id: current_user&.id)
    @moods = Mood.all
  end
  
  

  private

  def diary_entry_params
    params.require(:diary_entry).permit(:content, :mood_id, :image)
  end
  
  
end
