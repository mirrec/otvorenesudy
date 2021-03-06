module Core
  module Injector
    def inject(base, options = {})
      instantiate resolve(base, options), options[:args]
    end
    
    private
    
    def resolve(base, options = {})
      base = base.to_s.constantize
      
      words = []
      words << options[:prefix] unless options[:prefix].blank?
      words +=(options[:implementation] || self.class).to_s.split(/::/).last.split(/(?=[A-Z])/)
      words << options[:suffix] unless options[:suffix].blank?
      
      until words.empty? do
        name = words.join
        
        begin
          constant = base.const_get(name)
          
          if constant.is_a?(Class) && constant.to_s.start_with?(base.to_s)
            return constant
          end
        rescue NameError
        end
        
        words = words[1..-1]
      end
      
      base
    end
    
    def instantiate(type, args)
      return type          if type.class == Module
      return type.instance if type.respond_to? :instance
      return type.new      if args.blank?
      
      args = [args] unless args.is_a? Array
      
      type.new(*args)
    end
  end
end
