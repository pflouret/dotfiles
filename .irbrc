# stolen config from duane johnson

require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems'
require 'wirble'

ARGV.concat ["--readline",
             "--prompt-mode",
             "simple" ]

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

# Modify the prompt so it looks nice and tidy. Taken from Programming Ruby 2.
IRB.conf[:IRB_RC] = proc do |conf|
  leader = " " * conf.irb_name.length
  conf.prompt_i = "#{conf.irb_name} --> "
  conf.prompt_s = leader + ' \-" '
  conf.prompt_c = leader + ' \-+ '
  conf.return_format = leader + " ==> %s\n\n"
  puts "Welcome to interactive ruby!"
end

# Load and save each command in irb so we don't have to re-type stuff.  Taken from ctran.
# http://snipplr.com/view/1026/my-irbrc/
#HISTFILE = "~/.irb_history"
#MAXHISTSIZE = 1000

#begin
#  if defined? Readline::HISTORY
#    histfile = File::expand_path( HISTFILE )
#    if File::exists?( histfile )
#      lines = IO::readlines( histfile ).collect {|line| line.chomp}
#      puts "Read %d saved history commands from %s." %
#        [ lines.nitems, histfile ] if $DEBUG || $VERBOSE
#      Readline::HISTORY.push( *lines )
#    else
#      puts "History file '%s' was empty or non-existant." %
#        histfile if $DEBUG || $VERBOSE
#    end

#    Kernel::at_exit {
#      lines = Readline::HISTORY.to_a.reverse.uniq.reverse
#      lines = lines[ -MAXHISTSIZE, MAXHISTSIZE ] if lines.nitems > MAXHISTSIZE
#      $stderr.puts "Saving %d history lines to %s." %
#        [ lines.length, histfile ] if $VERBOSE || $DEBUG
#      File::open( histfile, File::WRONLY|File::CREAT|File::TRUNC ) {|ofh|
#  lines.each {|line| ofh.puts line }
#      }
#    }
#  end
#end

# Let's you use the "ri" command inside irb. Taken from Programming Ruby 2.
def ri(*names)
  system(%{ri #{names.map { |name| name.to_s }.join(" ")}})
end

Wirble.init
Wirble.colorize

