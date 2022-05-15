class KeywordCanSelectVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :keywords, :can_select_videos, :boolean
  end
end
