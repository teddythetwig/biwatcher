require 'yaml'
require 'open-uri'
require 'net/smtp'
require 'nokogiri'

credentials = YAML.load_file('email_cred.yaml')

while true

  #parse bitinstant homepage to check for BTC-E option
  page = Nokogiri::HTML(open('https://bitinstant.com/start_tx'))

  if page.css("select#dest_exchange > option[value='btce']").size == 1



    message = <<MESSAGE_END
From: Private Person <#{credentials['from']}>
To: A Test User <#{credentials['from']}>
Subject: SMTP e-mail test

This message is to alert you that BTC-E deposit is available on bitinstant.com
MESSAGE_END



    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', credentials['from'], credentials['password'], :login)
    smtp.send_message message, credentials['from'], credentials['from']
    smtp.finish
    
  end

  sleep 30*60*60

end
