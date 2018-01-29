#!/bin/sh -x

#GETH=/Users/abb/Documents/dvp/tools/go-ethereum/build/bin/geth
GETH=geth
BASEDIR=`dirname $0` 
DATADIR=$BASEDIR/datadir
IPCPATH=$DATADIR/geth.ipc
GENESIS=$BASEDIR/genesis.json
#GETH_ARGS="--datadir $DATADIR --nodiscover --maxpeers 0 --targetgaslimit 7500000 --rpc --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain=\"*\""
GETH_ARGS="--datadir $DATADIR --verbosity 4 --targetgaslimit 7500000 --rpc --rpcport 8545 --rpcaddr 0.0.0.0 --rpccorsdomain '*' --port 31313"

case $1 in
	run)
		if [ ! -d $DATADIR ] ; then
			$GETH --datadir $DATADIR init $GENESIS
			$GETH $GETH_ARGS --exec "loadScript('$BASEDIR/init_accounts.js')" console
		fi

		$GETH $GETH_ARGS --mine --minerthreads 1 --unlock 0,1,2,3,4,5 --password /dev/null console
		;;

	fund)
		$GETH $GETH_ARGS --exec "loadScript('$BASEDIR/fund_accounts.js')" attach $IPCPATH
		;;

	attach)
		$GETH attach $IPCPATH
		;;
esac

