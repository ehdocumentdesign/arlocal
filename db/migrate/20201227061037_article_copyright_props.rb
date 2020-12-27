class ArticleCopyrightProps < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :copyright_parser_id, :integer
    rename_column :articles, :copyright_notice, :copyright_text_markup
  end
end
