class Api::V1::ApiController < ApplicationController
  include Api::V1::Pagy
  before_action :set_includes

  protected
    def set_includes
      @includes = params[:includes] ? JSON.parse(params[:includes]).map(&:to_sym) : []
    end
end
