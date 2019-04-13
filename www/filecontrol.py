#!/usr/bin/python3
# -*- coding: utf-8 -*-# enable debugging
import cgi
import cgitb
import os
cgitb.enable()
print("Content-Type: text/html;charset=utf-8")
print("")


args = cgi.FieldStorage()
create_file = args.getvalue("create")
delete_file = args.getvalue("delete")
if delete_file == None:
    print("no filename to delete given...<br>")
else:
    print("removing /tmp/{}<br>".format(delete_file))
    os.remove("/tmp/{}".format(delete_file))

if create_file == None:
    print("no filename to create given...<br>")
else:
    print("creating /tmp/{}<br>".format(create_file))
    os.mknod("/tmp/{}".format(create_file))

    


     

