.PHONY: all format analyze test test-ci fix clean upgrade pub-outdated

## Run all checks (format, analyze, test)
all: format analyze test

## Format all Dart code
format:
	dart format .

## Run the analyzer
analyze:
	dart analyze --fatal-infos .

## Run all tests (VM)
test:
	dart test

## Run all tests (Chrome)
test-chrome:
	dart test -p chrome

## Run all tests for CI
test-ci: test test-chrome

## Target for the GitHub actions
test-app-ci: test-ci

## Apply auto-fixes
fix:
	dart fix --apply

## Check for outdated dependencies
pub-outdated:
	dart pub outdated

## Upgrade dependencies
upgrade: pub-outdated
	dart pub upgrade --major-versions --tighten

## Delete build artifacts
clean:
	rm -rf .dart_tool/
