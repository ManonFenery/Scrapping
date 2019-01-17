require 'nokogiri'
require 'open-uri'
require 'PRY'


page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))


mails = []

names = []


links = page.xpath('//*[@class="col3"]/li/a/@href')


links.each do |link|
	page_links = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr#{link}"))


	page_links.xpath('//*[@class="col3"]/li/a').each do |name|
	   names << name.text
	end

	page_links.xpath('//a[contains(@href, "@assemblee-nationale.fr")]').each do |mail|
		mails << mail.text
	end
end




names_mails_hash = Hash[names.zip(mails.map)]


array_of_hashes = []
names_mails_hash.each { |value| array_of_hashes << {value[0] => value[1]} }





