
include Lijab

Hooks::on_incoming_message do |contact, msg|
   Thread.new do
      system("aplay -q /usr/share/gajim/data/sounds/message2.wav &> /dev/null")
   end
end

