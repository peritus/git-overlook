============
git-overlook
============

:Author: `Filip Noetzel <filip@j03.de>`_
:Version: 0.01 (might work)
:Web: http://j03.de/projects/git-overlook/
:Download: `git-overlook.tar.gz <http://j03.de/git/?p=git-overlook.git;a=snapshot;sf=tgz>`_
:Git: ``clone http://j03.de/git/git-overlook.git/``
  ( `browse <http://j03.de/git/?p=git-overlook.git>`_,
  also `on github <http://github.com/peritus/git-overlook/>`_)

A `git <http://git.or.cz/>`__ extension for having certain changesets in your working dir, but not in
your tree. Think `.gitignore
<http://www.kernel.org/pub/software/scm/git/docs/gitignore.html>`__, but for
changesets, instead of files.

This is particularly useful for local changes that should stay local, e.g.
database/password configuration.

Installation
------------

For the moment, you need to add git-overlook to your path::

    $> cd $HOME
    $> git clone git://github.com/peritus/git-overlook.git
    $> echo 'PATH=$PATH:$HOME/git-overlook/' >> $HOME/.profile
    $> ogit overlook

Optionally, you can map ``ogit`` as your standard ``git``::

    $> echo 'alias git=ogit' >> $HOME/profile

This way you can use ``git`` instead of ``ogit`` in the following examples, so
there is no need to overwrite your `muscle memory
<http://en.wikipedia.org/wiki/Muscle_memory>`__.

Usage
-----

Then, use ``ogit`` ("omitting git" - a simple wrapper for git) instead of
``git`` for your daily work. Use ``ogit-overlook`` to manage changesets, git
should keep local.

``ogit overlook create``
  Set the current index as an overlooked changeset

``ogit overlook show``
  Show the current overlooked changeset

``ogit overlook clear``
  Remove the overlooked changeset

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
    +DATABASE_NAME='development_db'

Add the change to the index::

    $> ogit add config.inc

Advise git to overlook this change:
::

    $> ogit overlook create

The change is gone (at least from git's point of view), but the working dir
contains your change:
::

    $> ogit diff
    $> ogit diff --cached
    $> cat config.inc
    DATABASE_NAME='development_db'
    $> ogit show HEAD:config.inc
    # This is a sample configuration file
    
    DATABASE_NAME='' # your database name
    

Prototype warning
-----------------
This is a propotype - a proper version would be part of (a forked version of)
git. The wrapper around git is particular slow, so in case you have a slow
machine, you care about performance or your name is Linus Torvalds, please port
this to C.

License
-------

git-overlook is licensed as Beerware.
