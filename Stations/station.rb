class Station
  include InstanceCounter
  include Accessors
  include Validation
  attr_accessor :name
  attr_reader :trains

  NAME_FORMAT = /[a-zа-я]/i

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  validate :attribute_class, :type, "Station"

  def initialize(name)
    @name = name.to_s
    validate!
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

  def train_type(chosen_type)
    @trains.select { |_train| type == chosen_type }
  end

  def return_trains(&block)
    @trains.each do |train|
      block.call(train)
    end
  end
end
