class CreateSearchHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :search_histories do |t|
      t.string :ip, null: false
      t.string :term, null: false

      t.timestamps
    end
  end
end
