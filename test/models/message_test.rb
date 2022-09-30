require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @application = SystemApplication.new(name: "name")
    @application.save

    @chat = Chat.new(system_application: @application)
    @chat.save
  end

  test "should automate number creation on save" do
    msg = Message.new(chat: @chat)
    msg.save
    assert msg.number, "Message generated number should be unique"
  end

  test "should automate a unique number on creation for same chat" do
    msg1 = Message.new(chat: @chat)
    msg1.save
    msg2 = Message.new(chat: @chat)
    msg2.save
    assert_not_equal msg1.number, msg2.number, "Message numbers should be unique for same chat"
  end

  test "should not allow update message's number" do
    msg = Message.new(chat: @chat)
    msg.save
    assert_not msg.update(number: 11), "Update the message's number"
  end

  test "should not save application with body length greater than 3000" do
    msg = Message.new(chat: @chat)
    msg.body = "body "*3000
    assert_not msg.save, "Saved the application with body length greater than 5000"
  end
end
