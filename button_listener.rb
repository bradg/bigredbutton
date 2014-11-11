require 'rubygems'
require 'dream_cheeky'

class ButtonListener
  def self.listen
    DreamCheeky::BigRedButton.run do

      open do
        #`say "Armed!"`
      end

      close do
        #`say "Disarmed."`
      end

      push do
        time = Time.now
        if true # debug mode
          sound = %w/marvels-intro1 yay hulkroar avengers/.sample
          sound = "sounds/#{sound}.mp3"
          `afplay #{sound}`
        else
          if time.hour == 9 && time.min.between?(25,35) # approx stand up time
            sound = 'marvels-intro1'
          elsif time.day == 5 && time.hour > 15 # Friday after 3pm
            sound = 'yay.mp3'
          else
            sound = 'hulkroar.mp3'
          end
          sound = "sounds/#{sound}.mp3"
          `afplay #{sound}`
        end
      end
    end
  end
end

ButtonListener.listen
    
