#!/usr/bin/env bats

load environment

@test "Split with no branches/commits fails" {
	git init
	! $GSB master split '*.c'
}

@test "Splitting linear repo" {
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

@test "Splitting linear repo with remainder branch" {
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

@test "Splitting linear repo into multiple branches" {
	git init
	make_linear_commits

	$GSB -r rem-c master split-a a -- split-b b

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 86805e2c9e6c5ca403c67902e3613268a7373436 ]

	run git rev-parse split-b
	[ "$status" -eq 0 ]
	[ "$output" = fad0c9300a546117a1a1cb530b77ae60023d21f5 ]

	run git rev-parse rem-c
	[ "$status" -eq 0 ]
	[ "$output" = db0c1de05aa037b74b0c5874be9b620dc70ad6cc ]
}
