class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles, :id => false do |t|
      t.string :guid, primary_key: true
      t.integer :likes

      t.timestamps
    end
  end
end
