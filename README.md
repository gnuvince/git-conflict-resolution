Git conflict resolution
=======================

  Resolving conflicts in Git looks difficult and scary at first, but it's absolutely
  essential to working in a team. In this repo, you'll find demos and exercises for
  becoming more comfortable with conflict resolution.


Usage
-----

  Run the `create-playground.sh` shell script to create a playground.
  Go to the directory `/tmp/playground/exercises/` for the exercises.


Usual workflow
--------------

  A very common workflow is this:

  1. You want to create a new feature, fix a bug, etc.

  2. You update your working copy of the project:
  ```
  $ git checkout master
  $ git pull --rebase
  ```

  3. You create a branch for your work:
  ```
  $ git checkout -b my-new-feature
  ```

  4. Every once in a while, you ensure that you are not too far off
     from master. This is important and conflicts can happen here.
  ```
  $ git checkout master         # Back to master
  $ git pull --rebase           # Pull changes from GitHub
  $ git checkout my-new-feature # Go back to your own branch
  $ git rebase master           # Try to replay your changes on top of the new master
  ```


Useful commands
---------------

  Here are commands that are useful when you are dealing with a conflict.

  - **git rebase --abort**: if things have gone wrong, you can always abort
    a rebase with this command. You'll still have to deal with the conflict,
    but this is a nice “restart” feature.

  - **git merge --abort**: the same as above, but when you want to abort a
    merge operation.

  - **git diff myfile**: when a conflict occurs, this will show you where
    the conflict markers (the `<<<<<`, `=====`, and `>>>>>`) are.

  - **git add myfile**: after you've dealt with the conflicts in myfile, this
    will mark myfile as resolved.

  - **git rebase --continue**: after you've fixed all conflicts and marked all
    the files as resolved, this will continue the rebase.


Some general tips
-----------------

  “An ounce of prevention is worth a pound of cure,” as the saying goes. Here are
  some tips that can help prevent the difficulty of resolving conflicts.

  1. **Keep your branches small:** small branches touch fewer files and are live
     for a shorter period of time. This reduces the chances that someone else will
     introduce changes that will conflict with yours.

  2. **Rebase often:** Regularly rebase against the master branch (or the branch
     you forked off of). It's easier and faster to fix a few small conflicts than
     to fix one large conflict.

  3. **Talk to your teammates:** It's easier to manage conflicts if you know that
     large changes are coming than if they appear completely unexpected.
