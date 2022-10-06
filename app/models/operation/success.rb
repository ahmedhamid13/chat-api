# frozen_string_literal: true

module Operation
  class Success
    attr_reader :value

    def initialize(value:)
      @value = value
    end

    def errors?
      false
    end

    def success?
      true
    end
  end
end
