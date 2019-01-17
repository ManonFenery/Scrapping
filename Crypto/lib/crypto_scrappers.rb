require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def get_crypto_names(page)
names = []

page.xpath('//a[@class="link-secondary"]').each do |node|
	   names << node.text
	end
end

def get_crypto_prices(page)
prices = []

page.xpath('//a[@class="price"]').each do |price|
	  prices << price.text
	end

price_without_dollar = prices.map {|e| e.delete('$').to_f}
end


names_prices_hash = Hash[names.zip(price_without_dollar.map)]


array_of_hashes = []
names_prices_hash.each { |value| array_of_hashes << {value[0] => value[1]} }

puts array_of_hashes