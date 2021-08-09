module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def self.instances_count
      puts instances
    end
  end

  module InstanceMethods
    protected
    def create_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end