class CreateEmployeeAuthentications < ActiveRecord::Migration
  def change
    create_table :employee_authentications do |t|

      t.timestamps
    end
  end
end
