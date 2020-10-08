require 'nokogiri'
require 'open-uri'

def get_names
    page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
    return page.xpath('//*[@id="deputes-list"]//ul//li//a/text()').to_a
end

def get_emails
    page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
    emails = []
    array = []
    all_names = get_names
    i = 0

    page.xpath('//*[@id="deputes-list"]//ul//li//a/@href').to_a.each do |l|
        page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr' + l))
        emails << page.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a/text()').to_s.delete("mailto:")
    end
 
    while i < emails.length
        array << {:first_name => all_names[i].to_s.split(' ')[1], :last_name => all_names[i].to_s.split(' ')[2], :email => emails[i].to_s} 
        i+=1
    end
    puts array
end

get_emails


  








