task default: 'index.html'

desc 'make index html from list.csv'
file 'index.html' => ['list.csv'] do
  puts "aiu index.html"
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

