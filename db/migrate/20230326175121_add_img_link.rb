class AddImgLink < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :img_link, :string
  end
end
