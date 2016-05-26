#!/bin/bash

F=$(echo $1|tr -d '\r\n')
emacsclient -q `cygpath -aw $F`
