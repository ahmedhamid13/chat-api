# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class SystemApplicationsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @system_application = system_applications(:one)
      end

      test 'should get index' do
        get api_v1_applications_url, as: :json
        assert_response :success
      end

      test 'should show system_application' do
        get api_v1_application_url(@system_application.token), as: :json
        assert_response :success
      end

      test 'should create system_application' do
        assert_difference('SystemApplication.count') do
          post api_v1_applications_url, params: { application: { name: @system_application.name } }, as: :json
        end

        assert_response 201
      end

      test 'should update system_application' do
        patch api_v1_application_url(@system_application.token),
              params: { application: { name: @system_application.name } }, as: :json
        assert_response 200
      end

      test 'should destroy system_application' do
        assert_difference('SystemApplication.count', -1) do
          delete api_v1_application_url(@system_application.token), as: :json
        end

        assert_response 204
      end
    end
  end
end
