class CreateTravels < ActiveRecord::Migration[5.1]
  def change
    create_table :travels do |t|
      t.belongs_to :user, index: true
      t.belongs_to :destination, index: true
      t.string :purpose
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
