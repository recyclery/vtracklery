class AddCommentToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :comment, :text
  end
end
