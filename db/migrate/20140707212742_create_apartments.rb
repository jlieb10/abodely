class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string  :address
      t.string  :link
      t.string  :contact
      t.integer :price
      t.belongs_to :hunt, index: true
      t.timestamps
    end
  end
end
