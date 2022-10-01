# frozen_string_literal: true

module Api
  module V1
    module Pagy
      include Api::V1::Json
      include ::Pagy::Backend

      def pagy_json(pagy, includes = [], _options = {})
        return {} unless pagy

        res = pagy.as_json(include_root: false,
                           except: %w[id],
                           only: %w[count items page outset last pages offset from to prev next])

        res[:vars] = pagy.vars if includes.include?(:vars) && pagy.vars
        res
      end

      def pagys_json(pagys, includes = [], options = {})
        pagys.map { |s| pagy_json(s, includes, options) }
      end
    end
  end
end
