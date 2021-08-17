require_relative 'instance_counter.rb'

class Station
  include InstanceCounter
  attr_accessor :name
  attr_reader :trains

  NAME_FORMAT = /[a-zа-я]/i

  def initialize(name)
    @name = name.to_s
    validate!
    @trains = []
    create_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @trains
  end

  def get_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def train_type(type)
    @trains.select{ |train| type == type }
  end

  def return_trains(&block)
    @trains.each do |train| 
      block.call(train)
    end
  end

  protected

  def validate!
    raise "Название должно содержать минимум 3 символа" if name.length < 3
    raise "Название должно содержать только буквы" if name !~ NAME_FORMAT
  end
end