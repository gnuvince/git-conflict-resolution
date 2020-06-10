#!/bin/bash

: "${PLAYGROUND_DIR:=playground}"
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

prepare_exercise_03() {
    local dir="$EXERCISES_DIR"/03-both-commits
    cp -r "$DEMO_DIR"/alice "$dir"
    (
        cd "$dir"
        git checkout -b branch
        local bob; bob=$(cat <<EOF

def bobs_function():
    return "Bob"
EOF
              )
        echo "$bob" >> main.py
        git commit -am "Bob's version"
        git checkout master
        local alice; alice=$(cat <<EOF

def alices_function():
    return "Alice"
EOF
                          )
        echo "$alice" >> main.py
        git commit -am "Alice's version"
        git merge branch
    )
}

prepare_exercise_04() {
    local dir="$EXERCISES_DIR"/04-mix-and-match
    cp -r "$DEMO_DIR"/alice "$dir"
    (
        cd "$dir"
        git checkout -b branch
        sed -i 's/open(filename)/open(self.filename)/' main.py
        sed -i 's/(filename)/(self)/' main.py
        sed -i 's/^/    /' main.py
        sed -i '1s/^/class FileManip:\n/' main.py
        sed -i '2s/^/    def __init__(self, filename):\n        self.filename = filename\n\n/' main.py
        git commit -am "Bob's OO code"
        git checkout master
        local alice; alice=$(cat <<EOF

def count_lines(filename):
    n = 0
    with open(filename) as f:
        for line in f:
            n += 1
    return n
EOF
                          )
        echo "$alice" >> main.py
        git commit -am "Alice's version"
        git merge branch
    )
}

prepare_demo
prepare_exercise_01
prepare_exercise_02
prepare_exercise_03
prepare_exercise_04
