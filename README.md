# A Simple Ruby Facebook Messenger App
Example Facebook Messenger App in Ruby including fast deployments with [https://chatbotcity.com](https://chatbotcity.com)

Learn more about Facebook Messenger apps here: [https://developers.facebook.com/docs/messenger-platform](https://developers.facebook.com/docs/messenger-platform)

![alt tag](https://github.com/chatbotcity/ruby-facebook-messenger-app/raw/master/deployment_screenshot.gif)

## Running Locally

Make sure you have [Ruby](https://www.ruby-lang.org), and [Mechanize](https://github.com/sparklemotion/mechanize) installed.

```sh
git clone git@github.com:chatbotcity/ruby-facebook-messenger-app.git # clone this repository
cd ruby-facebook-messenger-app
gem install mechanize
```

## Get an API Key from Chatbot City [https://chatbotcity.com](https://chatbotcity.com)

- Sign into [https://chatbotcity.com](https://chatbotcity.com).
- Click "Add bot"
- Go throught the wizard (Select "Ruby" as the language)
- Under "My Bots", get your "Secret API Key" and "Bot ID"

In upload.rb replace these lines

```sh
bot_id = '<YOUR_BOT_ID>'
secret_api_key = '<YOUR_SECRET_API_KEY>'
```
With your Secret API KEY and Bot ID

## Deploy your Messenger App

```sh
ruby upload.rb
```
## Interact with Your Messenger App

Go to the facebook page you subcribed your messenger app to, and send your page a message.  Or go message your bot directly at m.me/yourbotname

## Gems available and limitations

Currently, only single file ruby applications are supported.  We prepend your app with 

```sh
require 'facebook/messenger'
require 'mechanize'
```
[facebook-messenger gem](https://github.com/hyperoslo/facebook-messenger)

[Mechanize gem](https://github.com/sparklemotion/mechanize)


## Get / Set String Variables

We provide convenience functions to let you store simple string data between requests.

These functions are:
```ruby
  set_var(key, value) #key and value are both strings
  get_var(key)
```
## License
All software in this repository is open source under The MIT License
