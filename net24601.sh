#!/bin/sh -x

BASEDIR=/Users/abb/Documents/dvp/net42
DATADIR=$BASEDIR/datadir
IPCPATH=$DATADIR/geth.ipc
GENESIS=$BASEDIR/genesis.json
GETH_ARGS="--datadir $DATADIR --nodiscover --maxpeers 0 --targetgaslimit 7500000 --rpc --rpcport 6545"

case $1 in
	run)
		if [ ! -d $DATADIR ] ; then
			geth --datadir $DATADIR init $GENESIS
			geth $GETH_ARGS --exec "loadScript('$BASEDIR/init_accounts.js')" console
		fi

		geth $GETH_ARGS --mine --minerthreads 1 --unlock 0,1,2,3 --password /dev/null console
		;;

	fund)
		geth $GETH_ARGS --exec "loadScript('$BASEDIR/fund_accounts.js')" attach $IPCPATH
		;;

	attach)
		geth attach $IPCPATH
		;;
esac

