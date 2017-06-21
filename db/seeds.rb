users = 10.times.map do
  auth_info = Faker::Omniauth.google
  self_introduction = Faker::Lorem
  User.create(name: auth_info[:info][:name], login_id: auth_info[:info][:name].downcase.tr(' ', '.'), email: auth_info[:id_info]['email'], password: 'password', self_introduction: Faker::Lorem.paragraph )
end

users.each do |user|
  (rand(10) + 5).times.each do
    user.blogs.create(title: Faker::Lorem.words((rand(3) + 2)).join(' '), body: Faker::Lorem.paragraphs((rand(10) + 3)).join("\n"))
  end
end

# javascript injection
user = User.create(name: 'javascript injection', login_id: 'js_injection', email: 'js_injection@somewhere.com', password: 'password', self_introduction: Faker::Lorem.paragraph )
user.create_measurement_tag(body: '<script>console.log(document.cookie);</script>')
(rand(10) + 5).times.each do
  user.blogs.create(title: Faker::Lorem.words((rand(3) + 2)).join(' '), body: Faker::Lorem.paragraphs((rand(10) + 3)).join("\n"))
end
