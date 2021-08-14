module Manufacturer
  attr_accessor :factory_name

  NAME_FORMAT = /[a-zа-я]/i

  def set_factory_name(name)
    self.factory_name = name
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Название должно содержать минимум 3 символа" if name.length < 3
    raise "Название должно содержать только буквы" if name !~ NAME_FORMAT
  end
end