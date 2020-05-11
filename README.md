<!--

* [ ] git rebase --abort
* [X] How to re-organize small commits into larger ones
* [X] Reminder to rebase on top of master often
* [X] "Clean" conflict where I want either my version or the remote's version
* [X] "Clean" conflict where I want both my version and the remote's version
* [ ] "Dirty" conflict where I want to keep some of my stuff and some of the remote's stuff
* [ ] theirs vs. ours

-->

Demo
====

1. How to rebase small commits into larger ones
-----------------------------------------------

  The goal of rebasing small commits into larger ones it to make it
  appear that you are smarter than you really are — to make it appear
  that your work happened in nice, logical chunks rather than in a
  chaotic manner.

  **Scenario:** I have a branch with a bunch of small, non-atomic
  commits; I want to squash them together into a larger one.

  0. Start a new branch, `documentation`
  1. Add doc-comment to `main:count_comments()`:
  ```
  """Count th3 numbr of comments."""
  ```
  2. Add doc-comment to `main:count_blank_lines()`:
  ```
  """Count th3 numbr of lines."""
  ```
  3. Fix typos of `main:count_comments()`
  4. Fix typos of `main:count_comments()`
  5. Add missing word "empty" to `main:count_comments()`
  6. `git rebase -i master`
  7. reword and fixup


2. Clean conflict — Keep either my version or the remote's version
------------------------------------------------------------------

  **Bob**:

  0. Start a branch, fix-empty
  1. Add this line:
  ```
  line = line.strip()
  ```
  2. Commit, merge, push

  **Alice**:

  0. Start a branch, fix-empty-also
  1. Change this line:
  ```
  -            if line == "":
  +            if line.strip() == "":
  ```
  2. Commit
  3. Checkout master, git pull --rebase
  4. Uh-oh, new version, better rebase!
  5. Checkout fix-empty-also, git rebase master
  6. CONFLICT!
  7. Fix the conflict with meld (pick Alice's version)
  8. git rebase --continue


3. Clean conflict — Keep both versions
--------------------------------------

  **Bob**:

  0. Start a branch
  1. Add function `count_lines()` at the end of main.py
  2. Commit, merge, push

  **Alice**:

  0. Start a branch
  1. Add function `count_chars()` at the end of main.py
  2. Commit
  3. Checkout master, git pull
  4. Checkout branch, git rebase master
  5. CONFLICT
  6. Show that using meld we can't keep both changes
  7. Show how to fix conflict in text editor
  8. git add main.py && git rebase --4. Dirty conflict
-----------------

  **Bob**:

  0. Start a branch
  1. Make code OO!!
  2. Commit, merge, push

  **Alice**:

  0. Start a branch
  1. Add a function `count_stars()`
  2. Commit
  3. Checkout master; git pull
  4. Checkout branch; git rebase master
  5. CONFLICT!
  6. This one requires COMMUNICATION!!!!!
