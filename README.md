<!--

* How to re-organize small commits into larger ones
* Reminder to rebase on top of master often
* "Clean" conflict where I want either my version or the remote's version
* "Clean" conflict where I want both my version and the remote's version
* "Dirty" conflict where I want to keep some of my stuff and some of the remote's stuff

-->

Demo
====

How to re-organize small commits into larger ones
-------------------------------------------------

  **Scenario:** I have a branch with a bunch of small, non-atomic
  commits; I want to squash them together into a larger one.

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
