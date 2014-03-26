class CreateImagesMultiBrands < ActiveRecord::Migration
  def change
    create_table :images_multi_brands do |t|

      t.timestamps
    end
  end
end
