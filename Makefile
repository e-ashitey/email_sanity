current_version=0.2.0

analyze:
	@dart analyze

test:
	@dart test

check: analyze test

publish-dry: check
	@dart pub publish --dry-run

publish: check
	@dart pub publish
