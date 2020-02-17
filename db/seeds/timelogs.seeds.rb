user = User.find_by(email: 'phec06@gmail.com')

timelog = Timelog.create(
  user: user,
  start: (DateTime.now - 2.hours),
  finish: (DateTime.now + 2.hours)
)

TagTaggable.find_or_create_by(taggable: timelog, tag_id: 16)

timelog = Timelog.create(
  user: user,
  start: (DateTime.now + 2.hours),
  finish: (DateTime.now + 3.hours)
)

TagTaggable.find_or_create_by(taggable: timelog, tag_id: 13)
