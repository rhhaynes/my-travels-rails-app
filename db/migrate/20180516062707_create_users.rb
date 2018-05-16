class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :slug
      t.string :github_uid
      t.string :password_digest
      t.timestamps
    end
  end
end
