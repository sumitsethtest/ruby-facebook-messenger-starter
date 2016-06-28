def is_number? string
  true if Float(string) rescue false
end

def get_state(sender)
  state = get_var(sender + 'game-state')
  if(!state || state.empty?)
    set_var(sender + 'game-state', 'INIT')
    return 'INIT'
  end
  return state
end

Bot.on :message do |message|
begin
  state = get_state(message.sender["id"])
  if state == 'INIT'
    Bot.deliver(
      recipient: message.sender,
      message: button_template(
        :text => 'Hello there!  I\'m thinking of a number.  Are you ready to try to guess it?',
       # :text => 'Guess a number?',
        :buttons => [{type: 'postback', title: 'Yes', payload: 'play_game'},
          {type: 'postback', title: 'Not right now', payload: 'no_game'}]
      ))
  end

 if state == 'PLAYING'
    number = get_var(message.sender["id"] + 'secret-number').to_i
    guess = message.text
    if !is_number?(guess)
      Bot.deliver(
        recipient: message.sender,
        message: {
          text: "I'm sorry, I wasn't able to parse that.  Please guess a number."
        }
      )
    else
      guess = guess.to_i
      my_text = ''
      if number > guess
        Bot.deliver(
          recipient: message.sender,
          message: {
            text: 'Your guess is too low.  Please guess again.'
          }
        )
      elsif number < guess
        Bot.deliver(
          recipient: message.sender,
          message: {
            text: 'Your guess is too high.  Please guess again.'
          }
        )
      elsif number == guess
        set_var(message.sender["id"] + 'game-state', 'INIT')
        Bot.deliver(
          recipient: message.sender,
          message: button_template(
            :text => 'Congratulations! You guessed right!  Would you like to play again?',
            :buttons => [{type: 'postback', title: 'Yes', payload: 'play_game'},
              {type: 'postback', title: 'Not right now', payload: 'no_game'}]
          ))
      end
    end
  end

rescue Exception => e  
  Bot.deliver(
    recipient: message.sender,
    message: {
      text: e.message[0..190]
    }
  )
end
end

Bot.on :postback do |postback|
  if postback.payload == 'play_game'
    set_var(postback.sender["id"] + 'secret-number', rand(1000000).to_s)
    set_var(postback.sender["id"] + 'game-state', 'PLAYING')
    Bot.deliver(
      recipient: postback.sender,
      message: {
        text: 'Ok, try to guess the number between 1 and a million.'
      }
    )
  end
  if postback.payload == 'no_game'
    set_var(postback.sender["id"] + 'game-state', 'INIT')
    Bot.deliver(
      recipient: postback.sender,
      message: {
        text: 'Ok, maybe some other time.'
      }
    )
  end
end
