class KeywordOrderSelecting < ActiveRecord::Migration[6.1]
  def change
    add_column :keywords, :can_select_events, :boolean
    add_column :keywords, :order_selecting_albums, :integer
    add_column :keywords, :order_selecting_events, :integer
    add_column :keywords, :order_selecting_pictures, :integer
    add_column :keywords, :order_selecting_videos, :integer
  end
end
