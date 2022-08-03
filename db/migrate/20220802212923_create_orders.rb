class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :project_id
      t.string :status

      t.timestamps
    end
  end
end
