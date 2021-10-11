class AddAasmStateToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :aasm_state, :string
  end
end
