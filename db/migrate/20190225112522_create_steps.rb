class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer "step"
      t.integer "tour_id"
      t.string "head"
      t.string "body"
      t.string "type"
      t.string "video_url"
      t.string "image_url"
      t.integer "est_time"
      t.timestamps
    end
  end
end
