class AddActivityIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :activity_id, :integer
  end
end


