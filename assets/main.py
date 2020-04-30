def count_comments(filename):
    comments = 0
    with open(filename) as f:
        for line in f:
            if line.startswith("#"):
                comments += 1
    return comments

def count_blank_lines(filename):
    blanks = 0
    with open(filename) as f:
        for line in f:
            if line == "":
                blanks += 1
    return blanks
