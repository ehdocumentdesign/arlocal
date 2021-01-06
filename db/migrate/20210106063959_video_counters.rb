class VideoCounters < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :keywords_count, :integer
    add_column :keywords, :videos_count, :integer
  end
end
