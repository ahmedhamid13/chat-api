# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class MessagesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @message = messages(:one)
      end

      test 'should get index' do
        get api_v1_application_chat_messages_url(application_id: @message.chat.system_application.token, chat_id: @message.chat.number),
            as: :json
        assert_response :success
      end

      test 'should show message' do
        get api_v1_application_chat_message_url(application_id: @message.chat.system_application.token, chat_id: @message.chat.number, id: @message.number),
            as: :json
        assert_response :success
      end

      test 'should create message' do
        assert_difference('Message.count') do
          post api_v1_application_chat_messages_url(application_id: @message.chat.system_application.token, chat_id: @message.chat.number),
               params: { message: { body: @message.body } }, as: :json
        end

        assert_response 201
      end

      test 'should update message' do
        patch api_v1_application_chat_message_url(application_id: @message.chat.system_application.token, chat_id: @message.chat.number, id: @message.number),
              params: { message: { body: @message.body } }, as: :json
        assert_response 200
      end

      # test "should destroy message" do
      #   assert_difference("Message.count", -1) do
      #     delete api_v1_application_chat_message_url(application_id: @message.chat.system_application.token, chat_id: @message.chat.number, id: @message.number), as: :json
      #   end

      #   assert_response 204
      # end
    end
  end
end
