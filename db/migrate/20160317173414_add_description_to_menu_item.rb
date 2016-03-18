class AddDescriptionToMenuItem < ActiveRecord::Migration
  def change
    add_column :menu_items, :description, :string
  end
end
