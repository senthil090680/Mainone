class CreatePrincipalDetails < ActiveRecord::Migration
  def change
    create_table :principal_details do |t|

      t.timestamps
    end
  end
end
