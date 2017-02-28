# git-split-branch

**git-split-branch** splits a single git branch into multiple branches, each
of which contains a specified set of the original branch's files and only the
commits which affect that set.

This is a similar effect to what
[**git-filter-branch**](https://github.com/git/git/tree/master/git-filter-branch.sh)
would produce by using an index filter to select specific files.  (In fact,
git-split-branch is obviously and unabashedly based on git-filter-branch.)
However, git-filter-branch can only rewrite a single branch, whereas
git-split-branch is able to create any number of branches.  In addition,
git-split-branch assigns the leftover files to a "remainder" branch or rewrite
the original source to contain only the leftovers.

On the other hand, git-filter-branch allows for other filters to be applied,
while git-split-branch is single in its purpose.

This utility was motivated by the desire to migrate a large $HOME repository
to [vcsh](https://github.com/RichiH/vcsh).  This repository contained seven
years of configuration, grad school work, personal writings, code for side
projects, etc.  It had originally been hosted in Subversion as a single, large
repository, and it was later converted to Git via git-svn but not restructured
into smaller, more logical units.  git-split-branch was written to split this
repository into smaller units without having to iterate seven years of commits
for every split.

The tool took 24 minutes to split 2750 commits into 60 branches.
