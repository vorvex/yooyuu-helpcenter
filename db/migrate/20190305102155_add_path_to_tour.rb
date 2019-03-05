class AddPathToTour < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :path, :string
    add_column :tours, :final_path, :string
  end
end
