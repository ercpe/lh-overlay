#!/sbin/openrc-run
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DAEMON="/usr/sbin/stallone"

depend() {
	need net
}

start() {
	ebegin "Starting stallone deamon"
	start-stop-daemon --start --pidfile $PIDFILE --oknodo --exec $DAEMON -- -D
	eend $?
}

stop() {
	ebegin "Stopping stallone deamon"
	start-stop-daemon --stop --signal KILL --pidfile $PIDFILE 
	eend $?
}

