module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
    protected
    def set_instance
      @instances ||= 0
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