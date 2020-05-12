#!/bin/bash

set -o errexit

: "${PLAYGROUND_DIR:=/tmp/playground}"
: "${DEMO_DIR:=$PLAYGROUND_DIR/demo}"
: "${EXERCISES_DIR:=$PLAYGROUND_DIR/exercises}"

rm -rf "$PLAYGROUND_DIR"
mkdir -p "$DEMO_DIR"
mkdir -p "$EXERCISES_DIR"

prepare_demo() {
    # Create a bare repo + two working copies
    (
        cd "$DEMO_DIR"
        mkdir -p origin
        git init --bare origin
        git clone origin alice
        git clone origin bob
    )

    # Use the name "Alice <alice@company.com>" in the first working copy
    (
        cd "$DEMO_DIR"/alice
        cat >>"$DEMO_DIR"/alice/.git/config <<EOF
[user]
        name = Alice
        email = alice@company.com
EOF
    )

    # Use the name "Bob <bob@company.com>" in the first working copy
    (
        cd "$DEMO_DIR"/bob
        cat >>"$DEMO_DIR"/bob/.git/config <<EOF
[user]
        name = Bob
        email = bob@company.com
EOF
    )

    # Copy main.py to Alice's working directory, commit, and push
    cp assets/main.py "$DEMO_DIR"/alice/
    (
        cd "$DEMO_DIR"/alice/
        git add main.py
        git commit -m "add main.py"
        git push origin master
    )

    # Pull main.py in Bob's working directory
    (
        cd "$DEMO_DIR"/bob/
        git pull --rebase
    )
}

add_line() {
    local filename="$1"
    local line_above="$2"
    local new_line="$3"

    declare -a ed_cmds=(
        /"$line_above"
        a
        "$new_line"
        .
        w
        q
    )
    printf "%s\n" "${ed_cmds[@]}" | ed -s "$filename"
}

add_line_before() {
    local filename="$1"
    local line_before="$2"
    local new_line="$3"

    declare -a ed_cmds=(
        /"$line_before"
        i
        "$new_line"
        .
        w
        q
    )
    printf "%s\n" "${ed_cmds[@]}" | ed -s "$filename"
}

prepare_exercise_01() {
    local dir="$EXERCISES_DIR"/01-squash-commits
    cp -r "$DEMO_DIR"/alice "$dir"
    (
        cd "$dir"
        add_line main.py "count_comments" '    "Count th3 number of comments."'
        git commit -am 'Add doc to count_coments'
        add_line main.py "count_blank_lines" '    "Count the numbr of lines."'
        git commit -am 'Add doc to count_blank_lines'
        sed -i s/th3/the/ main.py
        git commit -am "typo"
        sed -i s/numbr/number/ main.py
        git commit -am "typo"
        sed -i 's/of lines/of empty lines/' main.py
        git commit -am "fix doc"
    )
}

prepare_exercise_02() {
    local dir="$EXERCISES_DIR"/02-either-commit
    cp -r "$DEMO_DIR"/alice "$dir"
    (
        cd "$dir"
        git checkout -b branch
        add_line_before main.py 'line ==' '            line = line.strip()'
        git commit -am "Bob's version"
        git checkout master
        sed -i 's/line ==/line.strip() ==/' main.py
        git commit -am "Alice's version"
        git merge branch
    )
}

prepare_demo
prepare_exercise_01
prepare_exercise_02
