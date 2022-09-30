def generate_chat(app_id)
  ch = Chat.create!(
    system_application_id: app_id
  )
  generate_messages(ch.id)
end

def generate_messages(ch_id)
  3..9.times do |i|
    Message.create!(
      chat_id: ch_id
    )
  end
end

app_1 = SystemApplication.create!(
  name: 'app 1'
)
generate_chat(app_1.id)

app_2 = SystemApplication.create!(
  name: 'app 2'
)
generate_chat(app_2.id)