class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.text :email
      t.references :user

      t.timestamps
    end
  end
end
