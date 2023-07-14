class RemoveColumnsFromCommentsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :author_id_id
    remove_column :comments, :post_id_id
  end
end
