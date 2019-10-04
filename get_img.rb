require 'open-uri'

open('list.csv').each do |line|
  img  = line.split(',')[0]
  name = line.split(',')[1]

  puts name

  # save img data
  basename = File.basename(img)
  open("img/#{basename}.png", 'w'){|f| f.write open(img).read }

  sleep 0.2
end
