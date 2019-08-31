class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :body
      t.integer :difficulty
      t.integer :answer_id
      t.integer :language_code, default: 0
      t.timestamps
    end
  end
end
