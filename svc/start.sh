ARGS="--datadir $DATA_DIR"

echo "Starting geth with arguments $ARGS $@"
exec /usr/local/bin/geth $ARGS "$@"
