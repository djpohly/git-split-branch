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
	[ "$output" = 2e177ee154aee27a2e10cf30b25acefbb752942c ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 65f64808f13983e338c77cd9e5be9a921d187016 ]
}

@test "Splitting linear repo with remainder branch" {
	git init
	make_linear_commits

	$GSB -r rem master split-a a

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 2e177ee154aee27a2e10cf30b25acefbb752942c ]

	run git rev-parse rem
	[ "$status" -eq 0 ]
	[ "$output" = 65f64808f13983e338c77cd9e5be9a921d187016 ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 10e8418dfa6a9136da9368970b8954f2856362b8 ]
}

@test "-r option works without the following space" {
	git init
	make_linear_commits

	$GSB -rrem master split-a a

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 2e177ee154aee27a2e10cf30b25acefbb752942c ]

	run git rev-parse rem
	[ "$status" -eq 0 ]
	[ "$output" = 65f64808f13983e338c77cd9e5be9a921d187016 ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 10e8418dfa6a9136da9368970b8954f2856362b8 ]
}

@test "Splitting linear repo into multiple branches" {
	git init
	make_linear_commits

	$GSB -r rem-c master split-a a -- split-b b

	run git rev-parse split-a
	[ "$status" -eq 0 ]
	[ "$output" = 2e177ee154aee27a2e10cf30b25acefbb752942c ]

	run git rev-parse split-b
	[ "$status" -eq 0 ]
	[ "$output" = 29cbbea5edd1c01131aff2cba75308061c1384f5 ]

	run git rev-parse rem-c
	[ "$status" -eq 0 ]
	[ "$output" = 7032187efd8b43043460e2cc1391da56315e7ab9 ]

	run git rev-parse master
	[ "$status" -eq 0 ]
	[ "$output" = 10e8418dfa6a9136da9368970b8954f2856362b8 ]
}
