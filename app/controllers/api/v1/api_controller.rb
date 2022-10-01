# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include Api::V1::Pagy
      before_action :set_includes

      protected

      def set_includes
        @includes = params[:includes] ? params[:includes].split(',').map(&:to_sym) : []
      end
    end
  end
end
