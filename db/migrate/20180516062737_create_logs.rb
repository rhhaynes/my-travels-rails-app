class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.belongs_to :travel, index: true
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
