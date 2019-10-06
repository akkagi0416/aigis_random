require 'erb'
require 'json'

MEMBER_MAX = 20

#
# make list json
#
# lists
#   [
#     ['img/a1.png', 'name1'],
#     ['img/a2.png', 'name2'],
#     ...
#   ]
#
lists = []
open('list.csv').each do |line|
  img  = line.chomp.split(',')[0]
  name = line.chomp.split(',')[1]
  img_ = File.basename(img)
  lists << ["img/#{img_}.png", name]
end

json_lists = lists.to_json

#
# output html
#
erb = ERB.new(open('index.html.erb').read)
# erb = ERB.new(DATA.read)
open('index.html', 'w'){|f| f.write erb.result(binding) }

# pp lists

