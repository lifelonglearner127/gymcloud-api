module Services

class BaseService

  attr_reader :result

  def self.input_params(*value)
    @@input_params_value = value.presence || []
  end

  def self.defaults(value = {})
    @@defaults_value = value
  end

  def self.run(method_name)
    @@run_method = method_name
  end

  def initialize(args = {})
    set_attributes(args)
    set_defaults if self.class.respond_to?(:defaults_value)
    self
  end

  def process
    @result = run
    self
  end

  private

  def set_attributes(args)
    @@input_params_value.each do |attr_name|
      instance_variable_set(:"@#{attr_name}", args[attr_name])
    end
  end

  def set_defaults
    @@defaults_value.each do |attr_name, default_value|
      if instance_variable_get(:"@#{attr_name}").nil?
        instance_variable_set(:"@#{attr_name}", default_value)
      end
    end
  end

  def run
    if @@run_method.is_a?(Proc)
      self.instance_eval(&@@run_method)
    elsif @@run_method.is_a?(Symbol)
      self.send(@@run_method)
    end
  end

end

end