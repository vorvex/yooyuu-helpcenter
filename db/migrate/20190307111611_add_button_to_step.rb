class AddButtonToStep < ActiveRecord::Migration[5.2]
  def change
    add_column  :steps, :secondary_button_link, :string
    add_column  :steps, :secondary_button_text, :string
  end
end
