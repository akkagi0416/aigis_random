task default: 'index.html'

img_dir = 'img'
directory img_dir

png_01 = "#{img_dir}/0a8751c7e22abbd3f7d76c537663bcc9d2114233eabc28e08e4c8705052e2c59.png"

desc 'make index html from list.csv'
file 'index.html' => ['make_html.rb', 'list.csv', png_01] do
  sh 'ruby make_html.rb'
end

file png_01 => img_dir do
  sh 'ruby get_img.rb'
end

desc 'list.csv from html'
file 'list.csv' => ['rank01.htm', 'rank02.htm', 'rank03.htm'] do
  sh 'ruby make_list.rb'
end

file 'rank01.htm' do
  sh 'ruby get_html.rb'
end

file 'rank02.htm' do
  sh 'ruby get_html.rb'
end

file 'rank03.htm' do
  sh 'ruby get_html.rb'
end

# get rank01-03.htm from web
task :get_html do
  sh 'ruby get_html.rb'
end

# get *.png
task :get_img do
  sh 'ruby get_img.rb'
end
