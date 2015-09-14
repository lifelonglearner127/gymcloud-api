module Services

module BaseService

  extend ActiveSupport::Concern

  included do

  attr_reader :result

  @@input_params_value = []
  @@defaults_value = {}
  @@run_method = nil

  def self.!(args = {})
    new(args).process.result
  end

  def self.input_params(*value)
    @@input_params_value = value.presence || []
  end

  def self.defaults(value = {})
    @@defaults_value = value
  end

  def self.run(method_name = nil, &block)
    if method_name.is_a?(Symbol)
      @@run_method = method_name
    elsif block_given?
      @@run_method = block
    end
  end

  def initialize(args = {})
    define_attributes(args)
    define_defaults
    self
  end

  def process
    @result = run
    self
  end

  private

  def define_attributes(args)
    @@input_params_value.each do |attr_name|
      instance_variable_set(:"@#{attr_name}", args[attr_name])
    end
  end

  def define_defaults
    @@defaults_value.each do |attr_name, default_value|
      if instance_variable_get(:"@#{attr_name}").nil?
        instance_variable_set(:"@#{attr_name}", default_value)
      end
    end
  end

  def run
    if @@run_method.is_a?(Proc)
      instance_eval(&@@run_method)
    elsif @@run_method.is_a?(Symbol)
      send(@@run_method)
    end
  end

  end

end

end
