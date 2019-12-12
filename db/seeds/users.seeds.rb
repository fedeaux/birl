errors = []

[
  {
    email: 'phec06@gmail.com'
  }
].each do |user_attributes|
  user = User.where(email: user_attributes[:email]).first_or_initialize
  password = ENV['PASSWORD'] || 'test1234'

  next if user.persisted? && user.valid_password?(password)

  user.assign_attributes user_attributes.merge(
                           password: password,
                           password_confirmation: password
                         )

  if user.save
    print '.'
    next
  end

  print 'F'
  errors.push user.errors
end

if errors.any?
  puts "\nCouldn't create some users"
  ap errors
else
  puts "\nCreated/Updated #{User.count} users"
end
