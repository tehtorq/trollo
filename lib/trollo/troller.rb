module Trollo

  module Troller

    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend,  ClassMethods
    end

    module InstanceMethods

      def trollable
        trollable_type.constantize.find(trollable_id)
      end

      def trollable=(thing)
        self.trollable_type = thing.class.name
        self.trollable_id = thing.id
      end
      
    end

    module ClassMethods

      def trolling(trollable)
        where(trollable_type: trollable.class.name, trollable_id: trollable.id)
      end
      
      def named(name)
        where(name: name).first
      end

    end
  end
end