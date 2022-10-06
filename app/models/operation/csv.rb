# frozen_string_literal: true

module Operation
  class Csv
    attr_reader :results, :errors

    def initialize(results: [], errors: [])
      @results = results
      @errors = errors
    end

    def errors?
      errors.empty? ? true : false
    end

    def success?
      results.present? ? true : false
    end

    def success_uids
      success? ? results.keys : []
    end

    def failure_uids
      errors.except(:base).present? ? errors.except(:base).keys : []
    end

    def status
      success? ? :ok : :unprocessable_entity
    end
  end
end
