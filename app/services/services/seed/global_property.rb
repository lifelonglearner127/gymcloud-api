module Services
module Seed

class GlobalProperty < BaseSeedService

  private

  def klass
    ::GlobalProperty
  end

  def file_path
    'spec/fixtures/seed/global_properties.yml'
  end

end

end
end
