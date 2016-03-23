module Services
module Seed

class GlobalPropertyUnit < BaseService

  def run
    create_records_from_fixtures
  end

  private

  def create_records_from_fixtures
    fixtures.map do |attrs|
      property = ::GlobalProperty.find_by!(symbol: attrs['symbol'])
      units = ::PropertyUnit.where(short_name: attrs['units'])
      property.property_units = units
    end
  end

  def fixtures
    @fixtures ||= YAML.load_file(file_path)
  end

  def file_path
    'spec/fixtures/seed/global_property_units.yml'
  end

end

end
end
