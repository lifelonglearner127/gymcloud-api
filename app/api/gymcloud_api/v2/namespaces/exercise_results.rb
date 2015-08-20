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
    exercise_result = ::ExerciseResult.new(filtered_params)
    authorize!(:create, exercise_result)
    exercise_result.save!
    present(exercise_result, with: Entities::ExerciseResult)
  end

  params do
    requires :id, type: Integer, desc: 'Exercise Result ID'
  end
  route_param :id do

    desc 'Read Exercise Result'
    get do
      exercise_result = ::ExerciseResult.find(params[:id])
      authorize!(:read, exercise_result)
      present exercise_result, with: Entities::ExerciseResult
    end

    desc 'Update Exercise Result'
    params do
      requires :is_personal_best, type: Boolean
    end
    patch do
      exercise_result = ::ExerciseResult.find(params[:id])
      exercise_result.assign_attributes(filtered_params)
      authorize!(:update, exercise_result)
      exercise_result.save!
      present exercise, with: Entities::ExerciseResult
    end

    desc 'Delete Exercise Result'
    delete do
      exercise_result = ::ExerciseResult.find(params[:id])
      authorize!(:delete, exercise_result)
      exercise_result.destroy
      present(exercise_result, with: Entities::ExerciseResult)
    end

    namespace :items do

      desc 'Create Result Item'
      params do
        requires :exercise_property_id, type: Integer
        requires :value, type: Integer
      end
      post do
        exercise_result = ::ExerciseResult.find(params[:id])
        authorize!(:create, exercise_result)
        attributes = filtered_params_with(exercise_result_id: params[:id])
        attributes.delete(:id)
        exercise_result_item = ::ExerciseResultItem.create!(attributes)
        present(exercise_result_item, with: Entities::ExerciseResultItem)
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
          exercise_result = ::ExerciseResult.find(params[:id])
          authorize!(:update, exercise_result)
          exercise_result_item = exercise_result.items.find(params[:item_id])
          if params[:value].blank?
            exercise_result_item.destroy
          else
            exercise_result_item.update_attributes!(filtered_params)
          end
          present(exercise_result_item, with: Entities::ExerciseResultItem)
        end

      end

    end

  end

end

end
end
