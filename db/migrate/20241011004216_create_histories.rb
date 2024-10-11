class CreateHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :histories do |t|
      t.references :trackable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.string :action, null: false
      t.string :tracked_field
      t.string :tracked_value

      t.timestamps
    end
  end
end
