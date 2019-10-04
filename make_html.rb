require 'erb'
require 'json'

lists = []
open('list.csv').each do |line|
  img  = line.chomp.split(',')[0]
  name = line.chomp.split(',')[1]
  img_ = File.basename(img)
  lists << ["img/#{img_}.png", name]
end

json_lists = lists.to_json

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
    <% 0.upto(19) do |i| %>
      .icon<%= i %>{
        top: 110px;
        right: <%= 105 + (i % 5)*111 %>px;
      }
    <% end %>
  </style>
</head>
<body>
  <header>
  </header>
  <main>
    <div class="screen">
      <div class="bg"></div>
      <% lists[0..19].each_with_index do |list, i| %>
        <div class="icon icon<%= i %>"><img src="<%= list[0] %>" alt="<%= list[1] %>"></div>
      <% end %>
    </div>
    <img id="img_aiu" src="" alt="">
    <button id="button">button</button>
  </main>
  <footer>
  </footer>
  <script>
    let json_lists = <%= json_lists %>
  </script>
  <script>
    document.getElementById('button').addEventListener('click', function(){
      let img = document.getElementById('img_aiu')
      let idx = getRandomIndex()
      img.src = json_lists[idx][0]
    })

    function getRandomIndex(){
      return Math.floor(Math.random() * json_lists.length)
    }
  </script>
</body>
</html>
