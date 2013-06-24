class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.date :fordate
      t.string :whichtype
      t.integer :count
      t.boolean :checkmark

      t.timestamps
    end
  end
end
