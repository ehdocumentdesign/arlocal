class AddVideoIsrc < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :isrc_country_code, :string
    add_column :videos, :isrc_designation_code, :string
    add_column :videos, :isrc_registrant_code, :string
    add_column :videos, :isrc_year_of_reference, :string
  end
end
