require 'nokogiri'
require 'open-uri'

def get_cities #Retourne une array contenant toutes les villes
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
    return page.xpath('//tr[3]//a/text()').to_a.drop(2).to_a
end

def get_email #Retourne une array de hash des villes avec le mails des mairies
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
    email = []

    page.xpath('//tr[3]//a/@href').to_a.map{|link| link.to_s.sub!(".", "")}.drop(1).to_a.each do |link|
        page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com"+link))
        email << page.xpath('//main//section[2]//table[1]//tbody//tr[4]//td[2]/text()')
    end

    return puts get_cities.map{|c| c.to_s}.zip(email.map{|e| e.to_s}).map{|c,e| {c => e}}.to_a
end

get_email
