require 'open-uri'
require 'nokogiri'
conf_name = ARGV[0]
doc = Nokogiri::HTML(open("http://confreaks.com/events/#{conf_name}"))
`mkdir -p  #{ENV['HOME']}/Movies/screencasts/confs/`
doc.css('a').select { |a| a['href'] =~ /videos/ }.map{ |a| a['href'] }.uniq.each do |link|
  link = "http://confreaks.com#{link}"
   doc_vid = Nokogiri::HTML(open(link))
   doc_vid.css('a').select { |a| a['href'] =~ /large/ }.map{ |a| a['href']}.each do |link|
     `wget -O #{ENV['HOME']}/Movies/screencasts/confs/#{/(.*)\/(.*)\?(.*)/.match(link)[2]} -v #{link}`
   end
end
