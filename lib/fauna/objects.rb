module Fauna
  ##
  # A Ref.
  #
  # Reference: {FaunaDB Special Types}[https://faunadb.com/documentation#queries-values-special_types]
  class Ref
    # The raw ref string.
    attr_accessor :value

    ##
    # Creates a Ref object from a string.
    #
    # +ref+:: A ref in string form.
    def initialize(ref)
      self.value = ref
    end

    # Converts the Ref to a string
    def to_s
      value
    end

    # Converts the Ref in Hash form.
    def to_hash
      { '@ref' => value }
    end

    # Converts the Ref in JSON form.
    def to_json(*a)
      to_hash.to_json(*a)
    end

    # Returns +true+ if +other+ is a Ref and contains the same value.
    def ==(other)
      return false unless other.is_a? Ref
      value == other.value
    end

    alias_method :eql?, :==
  end

  ##
  # A Set.
  #
  # Reference: {FaunaDB Special Types}[https://faunadb.com/documentation#queries-values-special_types]
  class Set
    # The raw set hash.
    attr_accessor :value

    ##
    # Creates a new Set with the given parameters.
    #
    # +params+:: Hash of parameters to build the Set with.
    #
    # Reference: {FaunaDB Special Types}[https://faunadb.com/documentation#queries-values-special_types]
    def initialize(params = {})
      self.value = params
    end

    # Converts the Set to Hash form.
    def to_hash
      { '@set' => value }
    end

    # Converts the Set to JSON form.
    def to_json(*a)
      to_hash.to_json(*a)
    end

    # Returns +true+ if +other+ is a Set and contains the same value.
    def ==(other)
      return false unless other.is_a? Set
      value == other.value
    end

    alias_method :eql?, :==
  end

  ##
  # An Event.
  #
  # Reference: {FaunaDB Events}[https://faunadb.com/documentation#queries-values-events]
  class Event
    # The microsecond UNIX timestamp at which the event occurred.
    attr_accessor :ts
    # Either +create+ or +delete+.
    attr_accessor :action
    # The ref of the affected instance.
    attr_accessor :resource

    ##
    # Creates a new event
    #
    # +ts+:: Microsecond UNIX timestamp
    # +action+:: Either +create+ or +delete+. (Optional)
    # +resource+:: Ref of the affected instance. (Optional)
    def initialize(ts, action = nil, resource = nil)
      self.ts = ts
      self.action = action
      self.resource = resource
    end

    # Converts the Event to Hash form.
    def to_hash
      { 'ts' => ts, 'action' => action, 'resource' => resource }.delete_if { |_, value| value.nil? }
    end

    # Converts the Event to JSON form.
    def to_json(*a)
      to_hash.to_json(*a)
    end

    # Returns +true+ if +other+ is a Event and contains the same ts, action, and resource.
    def ==(other)
      return false unless other.is_a? Event
      ts == other.ts && action == other.action && resource == other.resource
    end

    alias_method :eql?, :==
  end
end
