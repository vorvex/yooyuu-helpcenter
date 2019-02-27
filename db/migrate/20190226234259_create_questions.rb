class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string "head"
      t.string "body"
      t.string "image_url"
      t.string "thumbnail_url"
      t.string "video_url"
      t.string "image_url"
      t.string "type"
      t.timestamps
    end
  end
end
