class AddUnitToSaveToGlobalProperty < ActiveRecord::Migration
  def change
    add_column :global_properties, :save_property_unit_id, :integer

    ::GlobalProperty.find_by(symbol: 'intervals').destroy
    Services::Seed::GlobalProperty.!
    Services::Seed::PropertyUnit.!
    Services::Seed::GlobalPropertyUnit.!

    ExerciseProperty.find_in_batches(batch_size: 1000) do |properties|
      properties.each do |ex_prop|
        default_unit = ex_prop.personal_property.default_unit
        save_unit = ex_prop.personal_property.save_unit

        ex_prop.property_unit = default_unit

        if save_unit.short_name == 'g' && default_unit.short_name == 'lbs'
          k = 453.592
        elsif save_unit.short_name ==  'mm' && default_unit.short_name == 'in'
          k = 25.4
        elsif save_unit.short_name ==  'mm' && default_unit.short_name == 'ft'
          k = 304.8
        else
          k = 1
        end

        ex_prop.value = k * ex_prop.value if ex_prop.value
        ex_prop.value2 = k * ex_prop.value2 if ex_prop.value2
        ex_prop.save
      end
    end
  end
end
