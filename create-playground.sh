#!/bin/bash

set -o errexit

: "${PLAYGROUND_DIR:=/tmp/playground}"
: "${DEMO_DIR:=$PLAYGROUND_DIR/demo}"

rm -rf "$PLAYGROUND_DIR"
mkdir -p "$DEMO_DIR"

(
    pushd "$DEMO_DIR"
    mkdir -p origin
    git init --bare origin
    git clone origin alice
    git clone origin bob
    popd
)

(
    pushd "$DEMO_DIR"/alice
    cat >>"$DEMO_DIR"/alice/.git/config <<EOF
[user]
        name = Alice
        email = alice@company.com
EOF
    popd
)

(
    pushd "$DEMO_DIR"/bob
    cat >>"$DEMO_DIR"/bob/.git/config <<EOF
[user]
        name = Bob
        email = bob@company.com
EOF
    popd
)

cp assets/main.py "$DEMO_DIR"/alice/
(
    pushd "$DEMO_DIR"/alice/
    git add main.py
    git commit -m "add main.py"
    git push origin master
    popd
)

(
    pushd "$DEMO_DIR"/bob/
    git pull --rebase
    popd
)
