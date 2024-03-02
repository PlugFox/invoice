.PHONY: test integration

test:
	@fvm flutter test \
		--coverage \
		test/

integration:
	@fvm flutter test \
		--coverage \
		integration_test/app_test.dart
