class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :timezone

      t.timestamps
    end
    add_index :cities, :name, :unique => true
  end
end
