# frozen_string_literal: true

require 'test_helper'

class SystemApplicationTest < ActiveSupport::TestCase
  test 'should not save application without name' do
    application = SystemApplication.new
    assert_not application.save, 'Saved the application without a name'
  end

  test 'should not save application with chats_count less than 0' do
    application = SystemApplication.new(name: 'name')
    application.chats_count = -1
    assert_not application.save, 'Saved the application with chats_count less than 1'
  end

  test 'should not save application with chats_count more than the existed' do
    application = SystemApplication.new(name: 'name')
    application.chats_count = 5
    assert_not application.save, 'Saved the application with chats_count more than the existed'
  end

  test 'should not save application with name length greater than 255' do
    application = SystemApplication.new(token: 'token')
    application.name = 'name ' * 70
    assert_not application.save, 'Saved the application with name length greater than 255'
  end

  test 'should automate token creation on save' do
    application = SystemApplication.new(name: 'name')
    application.save
    assert_not_nil application.token, "System generate application's token"
  end

  test "should not allow update application's token" do
    application = SystemApplication.new(name: 'name')
    application.save
    assert_not application.update(token: 'token'), "Update the application's token"
  end

  test 'should automate a unique tokens on creation' do
    application1 = SystemApplication.new(name: 'name')
    application1.save
    application2 = SystemApplication.new(name: 'name')
    application2.save
    assert_not_equal application1.token, application2.token, 'Application tokens should be unique'
  end
end
