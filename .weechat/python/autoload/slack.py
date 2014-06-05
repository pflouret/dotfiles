import time
import weechat as w
from slacker import Slacker

TOKEN = "xoxp-2151843163-2151845305-2312749758-4fdde1"
slack = Slacker(TOKEN)
all_channels = {}

def _channels():
    il = w.infolist_get("buffer", "", "")
    channels = []
    if il:
        while w.infolist_next(il):
            #w.prnt("", "2. %s - %s - %s" % (w.infolist_string(il, "localvar_server"), w.infolist_string(il, "localvar_type"), w.infolist_string(il, "localvar_channel")))
            name = w.infolist_string(il, "full_name")
            if name.startswith("irc.slack."):
                channels.append(name.replace("irc.slack.", "", 1))
        w.infolist_free(il)
    return channels

def unread_cb(data, buffer, command):
    global all_channels
    channels = []
    if command.find("set_unread_current_buffer") >= 0:
        if w.buffer_get_string(buffer, "localvar_server") == "slack" and \
           w.buffer_get_string(buffer, "localvar_type") in ["channel", "private"]:
            channels.append(w.buffer_get_string(buffer, "localvar_channel"))
    else:
        channels = _channels()

    for c in channels:
        c = c.lstrip("#")
        if c in all_channels:
            try:
                r = slack.channels.mark(all_channels[c], time.time())
            except:
                w.prnt("", "Error while setting unread marker on %s" % c)

    return w.WEECHAT_RC_OK

def conga(data, buffer, command):
    il = w.infolist_get("buffer", "", "")
    pronted = False
    if il:
        while w.infolist_next(il):
            if not pronted:
                w.prnt("", w.infolist_fields(il))
                pronted = True
            w.prnt("", "2. %i - %i - %i - %i - %s" % (w.infolist_integer(il, "first_line_not_read"), w.infolist_integer(il, "num_displayed"), w.infolist_integer(il, "lines_hidden"), w.infolist_integer(il, "num_history"), w.infolist_string(il, "name")))
        w.infolist_free(il)
    return w.WEECHAT_RC_OK

if __name__ == "__main__":
    w.register("slack", "pf@parb.es", "0.1", "MIT", "Pitiful slack integration", "", "")
    #w.hook_command_run("/input set_unread*", "conga", "")
    w.hook_command_run("/input set_unread*", "unread_cb", "")
    all_channels = {c['name']: c['id'] for c in slack.channels.list().body["channels"]}
    users = {u['id']: u['name'] for u in slack.users.list().body["members"]}
    all_channels.update({users[i["user"]]: i["id"] for i in slack.im.list().body["ims"] if i["user"] in users})
    #w.prnt("", "hai %d" % len(all_channels))
    #w.prnt("", str(all_channels))
