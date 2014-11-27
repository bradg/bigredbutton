require 'rubygems'
require 'dream_cheeky'

class ButtonListener

  def self.play(sound)
    sounds = { click: 'click2.mp3',
               beep:  'beep-01a.mp3',
               theme: 'marvels-intro1.mp3',
               yay:   'yay.mp3',
               hulk:  'huklroar.mp3',
               avengers: 'avengers.mp3',
    }

    if !`which omxplayer`.empty?
      player = 'omxplayer'
    elsif !`which afplay`.empty?
      player = 'afplay'
    else
      raise "Can't find omxplayer or afplay"
    end

    puts "Playing #{sounds[sound]}"
    `#{player} sounds/#{sounds[sound]}`
  end

  def self.listen

    # Notify we're ready by playing a beep
    puts "ButtonLister listening"
    play :beep

    # Count how many times the lid has been opened and the time of first lid-opening
    lid_count = 0
    last_opened = Time.now
    mode_change_seconds = 3

    DreamCheeky::BigRedButton.run do

      open do
        if last_opened > (Time.now - mode_change_seconds)
          lid_count += 1
        else
          lid_count = 1
          last_opened = Time.now
        end
        puts "Lid count: #{lid_count}"
        lid_count.times { play :click }
      end

      close do
        #`say "Disarmed."`
      end

      push do
        if lid_count == 2
          sound = :intro
        elsif lid_count == 3
          sound = :avengers
        elsif lid_count == 4
          sound = :yay
        else
          sound = :hulk
        end
        play sound
      end
    end
  end
end

ButtonListener.listen
    
