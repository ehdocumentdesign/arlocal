class RemoveInfoPage < ActiveRecord::Migration[6.1]
  def change
    drop_table :info_page
  end
end
