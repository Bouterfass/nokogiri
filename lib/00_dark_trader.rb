require 'nokogiri'
require 'open-uri'


def dark_trader()
    page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
    
    currencies = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td/div/a/text()')
    
    prices = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td/a/text()')
    
    hash = currencies.to_a.map{|c| c.to_s}.zip(prices.to_a.map{|p| p.to_s.delete('$')}).map{|c,p| {c => p}}.to_a
    
    puts hash
end

dark_trader()