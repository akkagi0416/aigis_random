require 'open-uri'

#
# get html
#
url_base = "http://s3-ap-northeast-1.amazonaws.com/assets.millennium-war.net/00/html/rankPAGE.htm"
1.upto(3) do |i|
  url = url_base.sub(/PAGE/, "0#{i}")
  html = open(url).read
  open((File.basename url), 'w'){|f| f.write html }

end

