module GymcloudAPI::V2
module Namespaces

class ExerciseResults < Base

  desc 'Create Exercise Result'
  post

  route_param :id do

    desc 'Read Exercise Result'
    get

    desc 'Update Exercise Result'
    patch

    desc 'Delete Exercise Result'
    delete

    namespace :items do

      desc 'Create Result Item'
      post

      route_param :item_id do

        desc 'Update Result Item'
        patch do
          # NOTE if :value is empty, item is deleted
        end

      end

    end

  end

end

end
end
