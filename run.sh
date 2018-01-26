#!/bin/sh -x

DATADIR=/Users/abb/Documents/dvp/net42/datadir
GENESIS=/Users/abb/Documents/dvp/net42/genesis.json
PWDFILE=/Users/abb/Documents/dvp/net42/geth.password
PASSWORD=`cat $PWDFILE`
GETH_ARGS="--verbosity 5 --datadir $DATADIR --nodiscover --maxpeers 0 --mine --targetgaslimit 7500000 --rpc --password $PWDFILE"

case $1 in
	init)
		geth --datadir $DATADIR init $GENESIS

		geth --datadir $DATADIR --exec "personal.newAccount('$PASSWORD')" console
		geth --datadir $DATADIR --exec "personal.newAccount('$PASSWORD')" console
		geth --datadir $DATADIR --exec "personal.newAccount('$PASSWORD')" console
		geth --datadir $DATADIR --exec "personal.newAccount('$PASSWORD')" console

		geth --datadir $DATADIR --exec "eth.accounts.map(function(acc) { personal.unlockAccount(acc, '$PASSWORD', 999999); })" console
		geth $GETH_ARGS --minerthreads 4 console
		;;

	run)
		geth --datadir $DATADIR --exec "eth.accounts.map(function(acc) { personal.unlockAccount(acc, '$PASSWORD', 999999); })" console
		geth $GETH_ARGS --minerthreads 1 console
		;;

	removedb)
		geth --datadir $DATADIR removedb
		;;

	attach)
		geth attach $DATADIR/geth.ipc
		;;
esac

