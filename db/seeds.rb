Administrator.create(login_id: 'admin', name: 'administrator', email: 'admin@example.com', password: 'password')

users = 10.times.map do
  auth_info = Faker::Omniauth.google
  User.create(name: auth_info[:info][:name], login_id: auth_info[:info][:name].downcase.tr(' ', '.'), email: auth_info[:info][:email], password: 'password', self_introduction: Faker::Lorem.paragraph )
end

100.times.each.with_index do |before_day|
  (rand(10) + 5).times.each do
    user = users.sample
    created_at = Time.zone.now - (100 - before_day).day
    status = [:published, :draft].sample
    user.blogs.create(title: Faker::Lorem.words(rand(2..5)).join(' '), body: Faker::Lorem.paragraphs(rand(3..13)).join("\n"), status: status, created_at: created_at, updated_at: created_at)
  end
end

# javascript injection
user = User.create(name: 'javascript injection', login_id: 'js_injection', email: 'js_injection@somewhere.com', password: 'password', self_introduction: Faker::Lorem.paragraph )
user.create_measurement_tag(body: '<script>alert(document.cookie);</script>')
(rand(10) + 5).times.each do
  user.blogs.create(title: Faker::Lorem.words((rand(3) + 2)).join(' '), body: Faker::Lorem.paragraphs((rand(10) + 3)).join("\n"), status: Blog.statuses[:published])
end

# redirection logs
1000.times.each.with_index do |i|
  RedirectionLog.create(
    to: ['/', '/blogs'].sample,
    referer: ['', 'http://localhost:3000', 'https://www.example.com'].sample,
    user_agent: Faker::Internet.user_agent,
    remote_ip: Faker::Internet.public_ip_v4_address,
    created_at: Time.zone.now - (100 - i / 10).day
  )
end
