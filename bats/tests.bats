load environment

@test "Split with no branches fails" {
	git init
	! $GSB master split '*.c'
}

@test "Splitting linear repo results in correct tree and blob contents" {
	git init
	make_linear_commits

	$GSB master split-a a

	run git ls-tree split-a
	[ "$status" -eq 0 ]
	[ "$output" = $'100644 blob 6e29a3cef150f3bc9b5440f0974d68b82e7f048e\ta' ]

	run git ls-tree master
	[ "$status" -eq 0 ]
	[ "$output" = $'100644 blob 898febce00ca379c70a8cc7e50e80b8d70703759\tb\n100644 blob 9fa64ae5c3c7c1eeb3711b53a3e6b6eda4a08511\tc' ]
}

@test "Splitting linear repo yields correct branches" {
	git init
	make_linear_commits

	$GSB master split-a a

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 86805e2c9e6c5ca403c67902e3613268a7373436 ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 80d9f830e102b3bb03a0e45a06efb8cb7f185d5b ]
}

@test "Splitting linear repo with remainder yields correct branches" {
	git init
	make_linear_commits

	$GSB -r rem master split-a a

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 86805e2c9e6c5ca403c67902e3613268a7373436 ]

	run git rev-parse rem
	[ "$status" -eq 0 ]
	[ "$output" = 80d9f830e102b3bb03a0e45a06efb8cb7f185d5b ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 458b84fa481b53afe2159189f297c0456c4cda3d ]
}

@test "-r option works without the following space" {
	git init
	make_linear_commits

	$GSB -rrem master split-a a

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 86805e2c9e6c5ca403c67902e3613268a7373436 ]

	run git rev-parse rem
	[ "$status" -eq 0 ]
	[ "$output" = 80d9f830e102b3bb03a0e45a06efb8cb7f185d5b ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 458b84fa481b53afe2159189f297c0456c4cda3d ]
}
