class EventTitleTextMarkup < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :title_parser_id, :integer
    add_column :events, :title_without_markup, :text
  end
end
