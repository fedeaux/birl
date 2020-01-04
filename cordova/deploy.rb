`curl http://birlapp.herokuapp.com > www/index.html`

index = File.read 'www/index.html'

# index.gsub!('href="/packs', 'href="http://birlapp.herokuapp.com/packs')
# index.gsub!('src="/packs', 'src="http://birlapp.herokuapp.com/packs')

index.gsub!('href="http://birlapp.herokuapp.com/packs', 'href="/packs')
index.gsub!('src="http://birlapp.herokuapp.com/packs', 'src="/packs')

File.open('www/index.html', 'w') do |f|
  f.write(index)
end

`cordova build android`
