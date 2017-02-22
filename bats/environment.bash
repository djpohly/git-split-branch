setup() {
	PATH="$BATS_TEST_DIRNAME/..:$PATH"
	export PATH
	GSB="git split-branch"

	LC_ALL=C
	export LC_ALL

	# Make a directory for testing and make it $HOME
	BATS_TESTDIR=$(mktemp -d -p "$BATS_TMPDIR")
	cd "$BATS_TESTDIR"
}

teardown() {
	# Don't saw off the branch you're sitting on
	cd /

	# Make sure removal will succeed even if we have altered permissions
	chmod -R u+rwX "$BATS_TESTDIR"
	rm -rf "$BATS_TESTDIR"
}

make_linear_commits() {
	export GIT_AUTHOR_NAME='A U Thor'
	export GIT_AUTHOR_EMAIL='author@example.com'
	export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
	export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL

	echo aye > a
	git add a
	GIT_AUTHOR_DATE='1000000001 +0000' GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE \
		git commit -m 'add a'

	echo bee > b
	git add b
	GIT_AUTHOR_DATE='1000000002 +0000' GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE \
		git commit -m 'add b'

	echo eh > a
	git add a
	GIT_AUTHOR_DATE='1000000003 +0000' GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE \
		git commit -m 'change a'

	echo cee > c
	git add c
	GIT_AUTHOR_DATE='1000000004 +0000' GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE \
		git commit -m 'add c'

	echo be > b
	git add b
	GIT_AUTHOR_DATE='1000000005 +0000' GIT_COMMITTER_DATE=$GIT_AUTHOR_DATE \
		git commit -m 'change b'
}
