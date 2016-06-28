require 'mechanize'
url = 'https://chatbotcity.com/api/v1/source'

bot_id = '<YOUR_BOT_ID>'
secret_api_key = '<YOUR_SECRET_API_KEY>'

a = Mechanize.new
a.post(url, {
    "secret_api_key" => secret_api_key,
    "bot_id" => bot_id,
    "uploaded_file" => File.new("chatbot.rb")
})
