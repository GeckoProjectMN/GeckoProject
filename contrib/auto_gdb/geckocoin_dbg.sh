#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.geckocoincore/geckocoind.pid file instead
geckocoin_pid=$(<~/.geckocoincore/testnet3/geckocoind.pid)
sudo gdb -batch -ex "source debug.gdb" geckocoind ${geckocoin_pid}
