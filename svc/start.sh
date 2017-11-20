ARGS="--datadir $DATA_DIR"

echo "Startomg geth with arguments $ARGS $@"
exec /usr/local/bin/geth $ARGS "$@"
