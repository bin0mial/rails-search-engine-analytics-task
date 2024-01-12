class AddSearchResultCountToSearchHistories < ActiveRecord::Migration[6.1]
  def change
    add_column :search_histories, :result_count, :bigint, null: false, default: 0
  end
end
