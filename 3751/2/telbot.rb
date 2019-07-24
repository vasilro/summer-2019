require 'telegram/bot'
require_relative 'chat.rb'
# require 'redis'

token = '800969602:AAFvEr0wrEkUc5ArQAoHaXSGnWmV2Yx5Xn4'
# redis = Redis.new

Telegram::Bot::Client.run(token) do |bot|
  chat = Chat.new(bot)
  bot.listen do |message|
    chat.call(message)
  end
end
