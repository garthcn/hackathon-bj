class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.column :wb_created_at   ,:datetime,  :nil => false
      t.column :wb_id           ,:integer,   :nil => false
      t.column :text            ,:string,    :length => 500, :nil => false
      t.column :reposts_count   ,:integer,   :default => 0
      t.column :comments_count  ,:integer,   :default => 0
      t.column :source          ,:string,    :length => 500
      t.column :favorited       ,:boolean,   :default => false
      t.column :truncated       ,:boolean,   :default => false
      t.column :geo             ,:string,    :default => nil
      t.column :in_reply_to_status_id ,:integer, :default => 0
      t.column :in_reply_to_user_id   ,:integer, :default => 0
      t.column :in_reply_to_screen_name ,:integer, :default => 0
      t.column :mid             ,:integer,   :default => 0
      t.column :user_id         ,:integer,   :blank  => false
      t.timestamps
    end
    add_index :tweets, :user_id
  end

  def self.down
    drop_table :tweets
  end
end
