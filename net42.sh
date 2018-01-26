#!/bin/sh -x

BASEDIR=/Users/abb/Documents/dvp/net42
DATADIR=$BASEDIR/datadir
IPCPATH=$DATADIR/geth.ipc
GENESIS=$BASEDIR/genesis.json
GETH_ARGS="--datadir $DATADIR --nodiscover --maxpeers 0 --targetgaslimit 7500000 --rpc"

case $1 in
	init)
		geth --datadir $DATADIR init $GENESIS
		geth $GETH_ARGS --exec "loadScript('$BASEDIR/init_accounts.js')" console
		$0 run
		;;

	run)
		geth $GETH_ARGS --mine --minerthreads 1 --unlock 0,1,2,3 --password /dev/null console
		;;

	fund)
		geth $GETH_ARGS --exec "loadScript('$BASEDIR/fund_accounts.js')" attach $IPCPATH
		;;

	removedb)
		geth --datadir $DATADIR removedb
		;;

	attach)
		geth attach $IPCPATH
		;;
esac

