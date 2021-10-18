class AddAasmStateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :aasm_state, :string
  end
end
