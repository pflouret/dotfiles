
include Lijab

Commands::Command.define :cowsay do
   usage "/cowsay <contact> <msg>"
   description %q{
 _______________________
< Send a message by cow >
 -----------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||}[1..-1]

   def run(args)
      contact, say = args.split(" ", 2).strip
      if say && Main.contacts.key?(contact)
         msg = "\n#{`cowsay #{say} 2>&1`}"
         if $?.success?
            Main.contacts[contact].send_message(msg, nil, false)
         else
            raise Commands::CommandError, %{shell complained: "#{msg.chomp}"}
         end
      end
   end

   def completer(line)
      contact = line.split[1] || ""
      Main.contacts.completer(contact, false) if contact.empty? || !Main.contacts.key?(contact)
   end
end

