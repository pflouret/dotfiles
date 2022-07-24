# stolen config from duane johnson

require 'rubygems'
require 'wirble'

#require 'irb/completion'
#require 'irb/ext/save-history'

ARGV.concat ["--readline",
             "--prompt-mode",
             "simple" ]

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# Modify the prompt so it looks nice and tidy. Taken from Programming Ruby 2.
IRB.conf[:IRB_RC] = proc do |conf|
  leader = " " * conf.irb_name.length
  conf.prompt_i = "#{conf.irb_name} --> "
  conf.prompt_s = leader + ' \-" '
  conf.prompt_c = leader + ' \-+ '
  conf.return_format = leader + " ==> %s\n\n"
  puts "Welcome to interactive ruby!"
end

Wirble.init
Wirble.colorize

