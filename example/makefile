help:
	@echo "Available commands:"
	@echo "  run-dev: Run the app in development mode"
	@echo "  run-pro: Run the app in production mode"
	@echo "  clean-get: Clean and get packages"


clean-get:
	flutter clean && flutter pub get

run-pro:
	flutter run --flavor pro -t lib/flavor/pro/pro_flavor.dart

run-dev:
	flutter run --flavor dev -t lib/flavor/dev/dev_flavor.dart