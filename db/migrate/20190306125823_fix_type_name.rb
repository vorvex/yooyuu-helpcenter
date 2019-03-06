class FixTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :type, :sort
    rename_column :steps, :type, :sort
  end
end
