class AddTipToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :tip, :text
  end
end
