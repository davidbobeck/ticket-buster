class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :problem
      t.boolean :fixed

      t.timestamps
    end
  end
end
