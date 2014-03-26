class CreatePosmTypes < ActiveRecord::Migration
  def change
    create_table :posm_types do |t|

      t.timestamps
    end
  end
end
