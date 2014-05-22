class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :nickname
      t.string :name
      t.string :email
      t.string :image
      t.text :description
      t.text :urls
      t.string :location
      t.references :user, index: true

      t.timestamps
    end
  end
end
