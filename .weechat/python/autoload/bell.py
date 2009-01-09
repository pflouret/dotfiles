import weechat, os

weechat.register("wee-bell-notify", "0.1", "", "wee-bell-notify: bell notifications")
weechat.add_message_handler("privmsg", "handle_message")

def handle_message(server, args):
  nick = weechat.get_info("nick")

  if nick in args:
    os.system("echo -ne '\a'")
    os.system("aplay -q /usr/share/skype/sounds/ChatIncoming.wav &> /dev/null &")

  return weechat.PLUGIN_RC_OK
