git-overlook
============

A git extension for having certain changesets in your working dir, but not in
your tree.

This is particularly useful for local changes that should stay local, e.g.
database/password configuration.

Installation
------------

For the moment, you need to add git-overlook to your path. This is a propotype
- a proper version would be part of (a forked version of) git.

Usage
-----

Then, use ``ogit`` ("omitting git" - a simple wrapper for git)instead of
``git`` for your daily work. Use ``git-overlook`` to manage changesets, git
should overlook.

``git-overlook create`` Set the current index as an overlooked changeset
``git-overlook show`` Show the current overlooked changeset
``git-overlook clear`` Remove the overlooked changeset

Example
-------

Clone some git repo:
::

$> ogit clone git://example.com/some/repo.git/
$> cd repo

Edit the example configuration to your needs:
::

$> vim config.inc
$> ogit diff

::

    diff --git a/config.inc b/config.inc
    index 285e2ab..377332d 100644
    --- a/config.inc
    +++ b/config.inc
    @@ -1,7 +1,7 @@
    # This is a sample configuration file
    
    -DATABASE_NAME='' # your database name
    -DATABASE_USER='' # your database user
    -DATABASE_HOST='' # your database host
    +DATABASE_NAME='development_db'
    +DATABASE_USER='root'
    +DATABASE_HOST='localhost'

Add the change to the index::

$> ogit add config.inc

Advise git to overlook this change (you will be asked for a insightful message,
just like ``git commit``:
::

$> git-overlook create

The change is gone (at least from git's point of view):
::

$> ogit diff --cached
$>












License
-------

git-overlook is licensed as Beerware.