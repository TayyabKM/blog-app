class RemoveColumnsFromLikesTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :post_id_id, :bigint
    remove_column :likes, :author_id_id, :bigint
  end
end
