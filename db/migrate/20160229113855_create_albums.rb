class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, index: true
      t.string :cover, index: true
    end

     create_table :photos do |t|
      t.integer :album_id, index: true
      t.string :name, index: true
      t.string :image, index: true
    end

    create_table :menus do |t|
      t.string :article, index: true
      t.string :title, index: true
      t.string :quantity, index: true
      t.string :price, index: true
      t.string :description, index: true
      t.string :image, index: true
    end

    create_table :menu_items do |t|
      t.integer :menu_id
      t.string :title
      t.string :quantity
      t.decimal :price, precision: 8, scale: 2
     
      t.timestamps null: false
    end
  end
end
