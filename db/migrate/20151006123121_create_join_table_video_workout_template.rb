class CreateJoinTableVideoWorkoutTemplate < ActiveRecord::Migration
  def change
    create_join_table :videos, :workout_templates do |t|
      t.index [:video_id, :workout_template_id]
      t.index [:workout_template_id, :video_id]
    end
  end
end
