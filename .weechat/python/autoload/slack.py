import time
import weechat as w
from slacker import Slacker
from threading import Thread

TOKEN = "xoxp-2151843163-2151845305-2312749758-4fdde1"
slack = Slacker(TOKEN)
all_channels = {}
private_groups = {}

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

def _mark(channels):
    for c in channels:
        cs = c.lstrip("#")
        if cs in all_channels:
            try:
                if c.startswith("#"):
                    if cs in private_groups:
                        r = slack.groups.mark(all_channels[cs], time.time())
                    else:
                        r = slack.channels.mark(all_channels[cs], time.time())
                else:
                    r = slack.im.mark(all_channels[cs], time.time())
                w.prnt("", "%s: %s" % (c, r.body["ok"] and "ok" or "not ok"))
            except:
                w.prnt("", "Error while setting unread marker on %s" % c)

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
        cs = c.lstrip("#")
        if cs in all_channels:
            try:
                if c.startswith("#"):
                    if cs in private_groups:
                        r = slack.groups.mark(all_channels[cs], time.time())
                    else:
                        r = slack.channels.mark(all_channels[cs], time.time())
                else:
                    r = slack.im.mark(all_channels[cs], time.time())
                #w.prnt("", "%s: %s" % (c, r.body["ok"] and "ok" or "not ok"))
            except:
                w.prnt("", "Error while setting unread marker on %s" % c)
    w.prnt("", "%d channels marked as read" % len(channels))

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
    users = {u['id']: u['name'] for u in slack.users.list().body["members"]}
    private_groups = {g['name']: g['id'] for g in slack.groups.list().body["groups"]}
    all_channels = {c['name']: c['id'] for c in slack.channels.list().body["channels"]}
    all_channels.update({users[i["user"]]: i["id"] for i in slack.im.list().body["ims"] if i["user"] in users})
    all_channels.update(private_groups)
    #w.prnt("", "hai %d" % len(all_channels))
    #w.prnt("", str(all_channels))
