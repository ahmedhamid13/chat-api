require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  setup do
    @application = SystemApplication.new(name: "name")
    @application.save
  end

  test "should not save chat without application" do
    chat = Chat.new(number: 1)
    assert_not chat.save, "Saved the chat without a application"
  end

  test "should automate number creation on save" do
    chat = Chat.new(system_application: @application)
    chat.save
    assert chat.number, "Chat generated number should be unique"
  end

  test "should automate a unique number on creation for same application" do
    chat1 = Chat.new(system_application: @application)
    chat1.save
    chat2 = Chat.new(system_application: @application)
    chat2.save
    assert_not_equal chat1.number, chat2.number, "Chat numbers should be unique for same application"
  end

  test "should not allow update chat's number" do
    chat = Chat.new(system_application: @application)
    chat.save
    assert_not chat.update(number: 11), "Update the chat's number"
  end

  test "should not save chat with messages_count less than 0" do
    chat = Chat.new(system_application: @application)
    chat.messages_count = -1
    assert_not chat.save, "Saved the chat with messages_count less than 1"
  end
end
