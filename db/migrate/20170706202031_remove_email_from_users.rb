class RemoveEmailFromUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.remove :email
    end
  end

  def down
    change_table :users do |t|
      t.string :email, limit: 513
    end
    execute "CREATE UNIQUE INDEX index_users_on_email ON users ((lower(email)));"
    execute "UPDATE users SET email = user_emails.email FROM user_emails WHERE user_emails.user_id = users.id"
    change_column_null :users, :email, false
  end
end
