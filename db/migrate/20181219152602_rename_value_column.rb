class RenameValueColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :money, :value, :denomination
  end
end
