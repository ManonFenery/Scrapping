require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_urls(page)

townhalls = []
page.xpath('//a[@class = "lientxt"]').each do |town|

  townhalls << town.text
  end

end

def get_townhall_emails(page)

page_individual = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/"))
email = []

news_links = page_individual.css("a")

news_links.each do |link|

    page_annuaire = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{link['href']}"))
    page_annuaire.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |mail|
    email << mail.text
    end
  end

my_hash = Hash[town.zip(email.map)]
print my_hash
end

get_townhall_urls(page)
get_townhall_emails(page)
