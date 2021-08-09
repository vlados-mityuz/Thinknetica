require_relative 'instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    create_instance
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
end