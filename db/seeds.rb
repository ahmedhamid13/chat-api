def generate_chats(app_id)
  22..37.times do |i|
    ch = Chat.create!(
      system_application_id: app_id
    )
    generate_messages(ch.id)
  end
end

def generate_messages(ch_id)
  5..13.times do |i|
    Message.create!(
      chat_id: ch_id
    )
  end
end

app_1 = SystemApplication.create!(
  name: 'app 1'
)
generate_chats(app_1.id)

app_2 = SystemApplication.create!(
  name: 'app 2'
)
generate_chats(app_2.id)

app_3 = SystemApplication.create!(
  name: 'app 3'
)
generate_chats(app_3.id)