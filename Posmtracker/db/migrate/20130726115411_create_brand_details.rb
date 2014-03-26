class CreateBrandDetails < ActiveRecord::Migration
  def change
    create_table :brand_details do |t|

      t.timestamps
    end
  end
end
