# git-split-branch

**git-split-branch** splits a single git branch into multiple branches, each
of which contains a specified set of the original branch's files and only the
commits which affect that set.

This is a similar effect to what
[**git-filter-branch**][2]
would produce by using an index filter to select specific files.  (In fact,
git-split-branch is obviously and unabashedly modified from
git-filter-branch.)  But unlike...

* **[git-subtree][1]**, it can split off an arbitrary set of files, not just a
  subdirectory.
* **git-filter-branch**, it can create multiple branches.
* **multiple git-filter-branch calls**, it only requires one pass over the
  commit history.
* **[other][3] [scripts][4] [that][5] [wrap][6] [git-filter-branch][7]**, see
  one of the previous two points.

[1]: https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh
[2]: https://github.com/git/git/blob/master/git-filter-branch.sh
[3]: https://github.com/ajdruff/git-splits
[4]: https://github.com/vangorra/git_split
[5]: https://github.com/phord/git-split/blob/master/git-split.sh
[6]: https://gist.github.com/aseigneurin/7531087
[7]: https://gist.github.com/tijn/5301258

In addition, git-split-branch assigns the leftover files to a "remainder"
branch or rewrites the original source branch to contain only the leftovers.

On the other hand, git-filter-branch allows for other filters to be applied,
while git-split-branch is single in its purpose.

## Usage

    git split-branch [-d <workdir>] [-r <remainder>] <source> <dest1> <paths1>... [ -- <dest2> <paths2>... ]...

This command will split the contents of the `<source>` branch, creating branch
`<dest1>` to contain only files matching `<paths1>`, branch `<dest2>` to
contain `<paths2>`, and so forth.  The remaining unsplit files will be written
to branch `<remainder>` if the `-r` flag is given; otherwise `<source>` will
be rewritten to contain the remaining files only.

As with git-filter-branch, the directory in which work is done can be
specified (e.g. on a tmpfs) with `-d`.

## Motivation

This utility was motivated by the desire to migrate a large $HOME repository
to [vcsh](https://github.com/RichiH/vcsh).  This repository contained seven
years of configuration, grad school work, personal writings, code for side
projects, etc.  It had originally been hosted in Subversion as a single, large
repository, and it was later converted to Git via git-svn but not restructured
into smaller, more logical units.  git-split-branch was written to split this
repository into smaller units without having to iterate seven years of commits
for every split.

The tool took 24 minutes to split 2750 commits into 60 branches.
