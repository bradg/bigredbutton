require 'rubygems'
require 'dream_cheeky'

class ButtonListener
  def self.listen
    if !`which omxplayer`.empty?
      player = 'omxplayer'
    elsif !`which afplay`.empty?
      player = 'afplay'
    else
      raise "Can't find omxplayer or afplay"
    end

    # Notify we're ready by playing a beep
    `#{player} sounds/beep-01a.mp3`

    DreamCheeky::BigRedButton.run do

      open do
        #`say "Armed!"`
      end

      close do
        #`say "Disarmed."`
      end

      push do
        time = Time.now
        if ENV['DEBUG']
          sound = %w/marvels-intro1 yay hulkroar avengers/.sample
          sound = "sounds/#{sound}.mp3"
          `#{player} #{sound}`
        else
          if time.hour == 9 && time.min.between?(25,35) # approx stand up time
            sound = 'marvels-intro1'
          elsif time.day == 5 && time.hour > 15 # Friday after 3pm
            sound = 'yay'
          else
            sound = 'hulkroar'
          end
          sound = "sounds/#{sound}.mp3"
          `#{player} #{sound}`
        end
      end
    end
  end
end

ButtonListener.listen
    
