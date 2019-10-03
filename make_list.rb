require 'nokogiri'

def pickup_data(file)
  data = []

  doc = Nokogiri::HTML(open(file))

  # top10
  doc.css('.rank_gr .rank_gr_li .element').each do |div|
    img   = div.css('img').attr('src').value
    name  = div.inner_html.match(/<br>(.*)<br>/)[1]
    score = div.css('c4').text.gsub(/[,票]/, '').to_i
    # puts "#{img} #{name} #{score}"
    data << [img, name, score]
  end

  # top11 -
  doc.css('.bg_03a ul li').each do |li|
    img   = li.css('img').attr('src').value
    name  = li.css('c2').text
    score = li.css('c3').text.gsub(/[,票]/, '').to_i
    # puts "#{img} #{name} #{score}"
    data << [img, name, score]
  end

  data
end

#
# make data csv
#
arr = []
arr += pickup_data('rank01.htm')
arr += pickup_data('rank02.htm')
arr += pickup_data('rank03.htm')

open('list.csv', 'w') do |f|
  arr.each do |row|
    f.puts "#{row[0]},#{row[1]},#{row[2]}"
  end
end
