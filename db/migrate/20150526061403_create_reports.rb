class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.references :city, index: true
      t.integer :job_num
      t.integer :type_id

      t.timestamps null: false
    end
    add_foreign_key :reports, :cities
  end
end
