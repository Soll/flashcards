class AddFieldsToCards < ActiveRecord::Migration
  def change
    add_column :cards, :cur_level, :integer, default: 0
    add_column :cards, :bad_attempts, :integer, default: 0
  end
end
