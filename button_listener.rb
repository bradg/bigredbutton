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
    puts "ButtonLister listening"
    `#{player} sounds/beep-01a.mp3`

    # Count how many times the lid has been opened and the time of first lid-opening
    lid_count = 0
    last_opened = Time.now
    mode_change_seconds = 3

    #if ENV["DEBUG"]
      #bigredbutton = FakeBigRedButton
    #else
      bigredbutton = DreamCheeky::BigRedButton
    #end

    bigredbutton.run do

      open do
        if last_opened > (Time.now - mode_change_seconds)
          lid_count += 1
        else
          lid_count = 1
          last_opened = Time.now
        end
        puts "Lid count: #{lid_count}"
      end

      close do
        #`say "Disarmed."`
      end

      push do
        if ENV['DEBUG'] # debug mode
          sound = %w/marvels-intro1 yay hulkroar avengers/.sample
          sound = "sounds/#{sound}.mp3"
          puts "Playing #{sound}"
          `#{player} #{sound}`
        else
          if lid_count == 2
            sound = 'marvels-intro1'
          elsif lid_count == 3
            sound = 'avengers'
          elsif lid_count == 4
            sound = 'yay'
          else
            sound = 'hulkroar'
          end
          sound = "sounds/#{sound}.mp3"
          puts "Playing #{sound}"
          `#{player} #{sound}`
        end
      end
    end
  end
end

ButtonListener.listen
    
