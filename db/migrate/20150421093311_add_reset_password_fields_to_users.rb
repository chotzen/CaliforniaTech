class AddResetPasswordFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
  end
end
