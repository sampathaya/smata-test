class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.references :category, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
