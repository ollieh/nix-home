#!/bin/sh
curl "https://api.cryptowat.ch/markets/prices" -s | jq -r '("BTC " + (.result["index:kraken-futures:cme-cf-brti"] | tostring) + " | XMR " + (.result["market:kraken:xmrusd"] | tostring) + " | SOL "  + (.result["market:binance-us:solusd"] | tostring))'

