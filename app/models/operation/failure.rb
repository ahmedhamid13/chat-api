# frozen_string_literal: true

module Operation
  class Failure
    attr_reader :errors

    def initialize(errors:)
      @errors = errors
    end

    def success?
      false
    end

    def errors?
      true
    end

    def value
      nil
    end
  end
end
