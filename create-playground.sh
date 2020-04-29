#!/bin/bash

PLAYGROUND_DIR="/tmp/playground"

rm -rf "$PLAYGROUND_DIR"
mkdir -p "$PLAYGROUND_DIR"
mkdir -p "$PLAYGROUND_DIR"/origin
git init --bare "$PLAYGROUND_DIR"/origin
git clone "$PLAYGROUND_DIR"/origin "$PLAYGROUND_DIR"/alice
git clone "$PLAYGROUND_DIR"/origin "$PLAYGROUND_DIR"/bob

cat >"$PLAYGROUND_DIR"/alice <<EOF
[user]
        name = Alice
        email = alice@company.com
EOF

cat >"$PLAYGROUND_DIR"/bob <<EOF
[user]
        name = Bob
        email = bob@company.com
EOF
