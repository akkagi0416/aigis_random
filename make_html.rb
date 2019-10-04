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
erb = ERB.new(DATA.read)
open('index.html', 'w'){|f| f.write erb.result(binding) }

# pp lists

__END__

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
  <style>
    body{
      margin: 0;
    }
    header{
      height: 40px;
      margin-bottom: 20px;
      background-color: #e9ecef;
      border-bottom: 1px solid #e9ecef;
    }
    main{
      width: 965px;
      margin: 0 auto;
      padding: 0;
    }
    footer{
      height: 300px;
    }
    .screen{
      position: relative;
    }
    .bg{
      width: 960px;
      height: 640px;
      background-image: url('img/bg.jpg');
      background-size: cover;
    }
    .icon{
      position: absolute;
    }
    <% 0.upto(MEMBER_MAX - 1) do |i| %>
      .icon<%= i %>{
        top:  <%= 110 + (i / 5) * 115 %>px;
        left: <%= 303 + (i % 5) * 111 %>px;
      }
    <% end %>
    .invisible{
      display: none;
    }
  </style>
</head>
<body>
  <header>
  </header>
  <main>
    <div class="screen">
      <div class="bg"></div>
      <% lists[0..(MEMBER_MAX - 1)].each_with_index do |list, i| %>
        <div class="icon icon<%= i %> invisible"><img id="img_icon<%= i %>" src="<%= list[0] %>" alt="<%= list[1] %>"></div>
      <% end %>
    </div>
    <img id="img_aiu" src="" alt="">
    <div id="menu">
      <button id="button">button</button>
      <input type="number" id="member_cnt" name="member_cnt" value="3" min="1" max="20">
    </div>
  </main>
  <footer>
  </footer>
  <script>
    let json_lists = <%= json_lists %>
  </script>
  <script>
    document.getElementById('button').addEventListener('click', function(){
      /* for check part
      let img = document.getElementById('img_aiu')
      let idx = getRandomIndex()
      img.src = json_lists[idx][0]
      img.alt = json_lists[idx][1]
      */

      // reset .invisible
      for(let i = 0; i < <%= MEMBER_MAX %>; i++){
        let icon = document.getElementsByClassName('icon')[i]
        if(!icon.classList.contains('invisible')){
          icon.classList.add('invisible')
        }
      }

      // pickup random icons
      let cnt = document.getElementById('member_cnt').value
      for(let i = 0; i < cnt; i++){
        let icon = document.getElementsByClassName('icon')[i]
        // invisible -> visible
        icon.classList.remove('invisible')

        let img = document.getElementById('img_icon' + i)
        let idx = getRandomIndex()
        console.log(img)
        img.src = json_lists[idx][0]
        img.alt = json_lists[idx][1]
      }
    })

    // get random icons index
    function getRandomIndex(){
      return Math.floor(Math.random() * json_lists.length)
    }
  </script>
</body>
</html>
