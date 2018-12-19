class AddConstrainsToMoney < ActiveRecord::Migration[5.2]
  def change
    ActiveRecord::Base.connection.execute(<<-EOQ)
      ALTER TABLE money ADD CONSTRAINT count_nonnegative CHECK (count >= 0);
    EOQ
  end
end
