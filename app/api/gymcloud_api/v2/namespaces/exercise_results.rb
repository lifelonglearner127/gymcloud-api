module GymcloudAPI::V2
module Namespaces

class ExerciseResults < Base

  desc 'Create Exercise Result'
  params do
    requires :workout_event_id, type: Integer
    requires :workout_exercise_id, type: Integer
    optional :is_personal_best, type: Boolean, default: 'false'
  end
  post do
    present ::ExerciseResult.create!(filtered_params.to_h), with: Entities::ExerciseResult
  end


  params do
    requires :id, type: Integer, desc: 'Exercise Result ID'
  end
  route_param :id do

    desc 'Read Exercise Result'
    get do
      present ::ExerciseResult.find(filtered_params[:id]), with: Entities::ExerciseResult
    end

    desc 'Update Exercise Result'
    params do
      requires :is_personal_best, type: Boolean
    end
    patch do
      exercise_result = ::ExerciseResult.find params[:id]
      exercise_result.update_attributes! filtered_params.to_h
      present exercise, with: Entities::ExerciseResult
    end

    desc 'Delete Exercise Result'
    delete do
      present ::ExerciseResult.destroy(params[:id]), with: Entities::ExerciseResult
    end

    namespace :items do

      desc 'Create Result Item'
      params do
        requires :exercise_result_id, type: Integer
        requires :exercise_property_id, type: Integer
        requires :value, type: Integer
      end
      post do
        present ::ExerciseResultItem.create!(filtered_params.to_h), with: Entities::ExerciseResultItem
      end

      params do
        requires :id, type: Integer, desc: 'Result Item ID'
      end
      route_param :item_id do

        desc 'Update Result Item'
        params do
          requires :value, type: Integer
        end
        patch do
          exercise_result_item = ::ExerciseResultItem.find params[:id]
          if params[:value].blank?
            exercise_result_item.destroy
          else
            exercise_result_item.update_attributes! filtered_params.to_h
          end
          present exercise_result_item, with: Entities::ExerciseResultItem
        end

      end

    end

  end

end

end
end
