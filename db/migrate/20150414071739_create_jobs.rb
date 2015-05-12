class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :url
      t.text :content
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
