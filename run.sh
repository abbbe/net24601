#!/bin/sh -x

DATADIR=/Users/abb/Documents/dvp/net42/datadir
GENESIS=/Users/abb/Documents/dvp/net42/genesis.json
GETH_ARGS="--verbosity 5 --datadir $DATADIR --nodiscover --maxpeers 0 --mine --targetgaslimit 7500000 --rpc --password $PWDFILE"

case $1 in
	init)
		geth --datadir $DATADIR init $GENESIS
		geth --datadir $DATADIR --exec "personal.newAccount('')" console
		;;

	run)
		geth $GETH_ARGS --minerthreads 1 console
		;;

	removedb)
		geth --datadir $DATADIR removedb
		;;

	attach)
		geth attach $DATADIR/geth.ipc
		;;
esac

