class AddOtpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :otp, :integer
    add_column :users, :otp_expiry, :datetime
  end
end
