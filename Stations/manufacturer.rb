module Manufacturer
  attr_accessor :factory_name

  NAME_FORMAT = /[a-zа-я]/i

  def factory_name_assingmnet(name)
    self.factory_name = name
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Название должно содержать минимум 3 символа' if name.length < 3
    raise 'Название должно содержать только буквы' if name !~ NAME_FORMAT
  end
end
