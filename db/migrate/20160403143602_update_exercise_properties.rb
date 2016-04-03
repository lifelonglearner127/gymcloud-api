class UpdateExerciseProperties < ActiveRecord::Migration
  def up
    intervals_proprty = ::GlobalProperty.find_by(symbol: 'intervals')
    intervals_proprty.andand.destroy
    Services::Seed::GlobalProperty.!
    Services::Seed::PropertyUnit.!
    Services::Seed::GlobalPropertyUnit.!

    ExerciseProperty.find_in_batches(batch_size: 1000) do |properties|
      properties.each do |ex_prop|
        default_unit = ex_prop.personal_property.default_unit
        save_unit = ex_prop.personal_property.save_unit

        ex_prop.property_unit = default_unit

        if save_unit.short_name == 'g' && default_unit.short_name == 'lbs'
          coefficient = 453.592
        elsif save_unit.short_name ==  'mm' && default_unit.short_name == 'in'
          coefficient = 25.4
        elsif save_unit.short_name ==  'mm' && default_unit.short_name == 'ft'
          coefficient = 304.8
        else
          coefficient = 1
        end

        ex_prop.value = coefficient * ex_prop.value if ex_prop.value
        ex_prop.value2 = coefficient * ex_prop.value2 if ex_prop.value2
        ex_prop.save
      end
    end
  end
end
