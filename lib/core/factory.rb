module Core
  class Factory
    include Core::Identify
    include Core::Output

    attr_reader :type,
                :create_block,
                :find_block

    def initialize(type, &find_block)
      @type         = type
      @create_block = lambda { |*args| @type.new }
      @find_block   = block_given? ? find_block : lambda { |*args| nil }
    end

    def create(*args)
      print "Creating new #{@type.name} ... "

      instance = call @create_block, *args

      puts "done (#{identify instance})"

      instance
    end

    def find(*args)
      print "Finding #{@type.name} by #{args.flatten(1).map { |arg| arg || '?' }.join ', '} ... "

      instance = call @find_block, *args

      if instance.nil?
        puts "failed (not found)"
      else
        puts "done (#{identify instance})"
      end

      instance
    end

    def find_or_create(*args)
      find(args) || create(args)
    end

    private

    def call(block, *args)
      *args = [] if args.nil? || args.empty?

      block.call(*args.flatten(1))
    end
  end  
end
