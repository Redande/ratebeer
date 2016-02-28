class AddAccountHaltToUser < ActiveRecord::Migration
  def change
    add_column :users, :halted, :boolean, :default => false
  end
end
