class Chat
  attr_accessor :message, :started, :entered, :check_ined
  attr_reader :rubizzians, :bot, :id

  def initialize(bot)
    @bot = bot
    @started = false
    @entered = false
    @check_ined = false
    @rubizzians = ['3751', '204', '211', '13', '380', '3135', '3172']
  end

  def call(message)
    token = '800969602:AAFvEr0wrEkUc5ArQAoHaXSGnWmV2Yx5Xn4'

    if started
      if entered
        bot.api.send_message(chat_id: message.chat.id, text: "You are working under id #{$id}")
      elsif rubizzians.include?(message.text)
        $id = message.text
        @entered = true
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Enter right id")
      end
    elsif message.text == '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}. Enter your id")
      @started = true
    else
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [['/start']], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "Press /start", reply_markup: answers)
    end

    if message.text == '/check_in' and entered
      bot.api.send_message(chat_id: message.chat.id, text: "Send me selfie")
      @check_ined = true
    elsif message.text == '/check_in'
      bot.api.send_message(chat_id: message.chat.id, text: "First you must /start and then enter you id")
    elsif entered and !check_ined
        answers =
          Telegram::Bot::Types::ReplyKeyboardMarkup
          .new(keyboard: [['/check_in']], one_time_keyboard: true)
        bot.api.send_message(chat_id: message.chat.id, text: "Press /check_in to start work", reply_markup: answers)
    end

    if message.text == '/check_out' and check_ined
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [['/check_in']], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "Great job! See you soon. Don't forget press /check_in to start work")
      @check_ined = false      
    elsif message.text == '/check_out'
      bot.api.send_message(chat_id: message.chat.id, text: "Need fully /check_in (include sending photo and geolocation")
    end

    if message.photo.last and check_ined
      file_id = message.photo.last.file_id
      file_path = bot.api.get_file(file_id: file_id)['result']['file_path']
      puts "https://api.telegram.org/file/bot#{token}/#{file_path}"

      kb = Telegram::Bot::Types::KeyboardButton.new(text: 'Send location', request_location: true)
      markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Send me location', reply_markup: markup)
    end

    if message.location and check_ined
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: [['/check_out']], one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: 'OK, have a productive work! When finish, press /check_out', reply_markup: answers)
    end
  end
end
