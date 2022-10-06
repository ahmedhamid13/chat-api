# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ChatsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @chat = chats(:one)
      end

      test 'should get index' do
        get api_v1_application_chats_url(application_id: @chat.system_application.token), as: :json
        assert_response :success
      end

      test 'should show chat' do
        get api_v1_application_chat_url(application_id: @chat.system_application.token, id: @chat.number), as: :json
        assert_response :success
      end

      test 'should create chat' do
        assert_difference('Chat.count') do
          post api_v1_application_chats_url(application_id: @chat.system_application.token),
               params: { chat: { number: @chat.number, system_application_id: @chat.system_application_id } }, as: :json
        end

        assert_response 201
      end

      test 'should update chat' do
        patch api_v1_application_chat_url(application_id: @chat.system_application.token, id: @chat.number),
              params: { chat: { number: @chat.number, system_application_id: @chat.system_application_id } }, as: :json
        assert_response 200
      end

      test 'should destroy chat' do
        assert_difference('Chat.count', -1) do
          delete api_v1_application_chat_url(application_id: @chat.system_application.token, id: @chat.number),
                 as: :json
        end

        assert_response 204
      end
    end
  end
end
