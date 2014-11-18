cd /home/pi/bigredbutton
source /home/pi/proxyon.sh
git fetch
git reset --hard FETCH_HEAD
git clean -df
/usr/bin/ruby button_listener.rb&
