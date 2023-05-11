class AddSenderToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :sender_id, :integer
  end
end
