class AddStatsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :stats, :string
  end
end
