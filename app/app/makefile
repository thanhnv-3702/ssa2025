pub_get:
	@echo "📥 Get dependencies and generating strings..."
	@fvm flutter pub get

code_gen:
	@echo "🔄 Generating code..."
	@fvm dart run build_runner build --delete-conflicting-outputs

clean:
	@echo "🧹 Cleaning project..."
	@fvm flutter clean

resource_gen:
	@echo "🧹 Cleaning resource_gen..."
	@sh resource_gen.sh

fresh:
	@echo "🧹 Clean and rebuild project"
	@fvm flutter clean
	@make pub_get
	@make resource_gen
	@make code_gen

build_apk_dev:
	@echo "▶️  Build app (dev)..."
	@fvm flutter build apk --release