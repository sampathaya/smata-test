class UpdateVerticalTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :verticals, :user, foreign_key: true
  end
end
