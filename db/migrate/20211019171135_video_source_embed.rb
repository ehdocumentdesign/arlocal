class VideoSourceEmbed < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :source_embed, :text
  end
end
