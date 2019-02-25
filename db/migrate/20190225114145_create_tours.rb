class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string "name"
      t.string "description"
      t.string "image_url"
      t.timestamps
    end
  end
end
