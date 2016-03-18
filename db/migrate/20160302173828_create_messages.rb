class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :article
      t.text :description
      t.string :picture, index: true

      t.timestamps null: false
    end
  end
end
