# Makefile for Ultroid testing and development

.PHONY: help test test-core test-plugins test-database test-updates test-all coverage install-test-deps clean lint format check

# Default target
help:
	@echo "🧪 Ultroid Development Commands"
	@echo "==============================="
	@echo ""
	@echo "Testing:"
	@echo "  test-deps     Install test dependencies"
	@echo "  test          Run all tests"
	@echo "  test-core     Run core functionality tests"
	@echo "  test-plugins  Run plugin tests"
	@echo "  test-database Run database tests"
	@echo "  test-updates  Run update system tests"
	@echo "  coverage      Run tests with coverage report"
	@echo ""
	@echo "Code Quality:"
	@echo "  lint          Run linting checks"
	@echo "  format        Format code with black"
	@echo "  check         Run all quality checks"
	@echo ""
	@echo "Utilities:"
	@echo "  clean         Clean temporary files"
	@echo "  install       Install bot dependencies"

# Install test dependencies
test-deps:
	@echo "📦 Installing test dependencies..."
	python3 run_tests.py --install-deps

# Install bot dependencies
install:
	@echo "📦 Installing bot dependencies..."
	pip3 install -r requirements.txt

# Run all tests
test:
	@echo "🧪 Running all tests..."
	python3 run_tests.py

# Run core tests
test-core:
	@echo "🧪 Running core tests..."
	python3 run_tests.py --directory "tests/test_core"

# Run plugin tests
test-plugins:
	@echo "🧪 Running plugin tests..."
	python3 run_tests.py --directory "tests/test_plugins"
	pytest tests/test_plugins.py -v

# Run database tests
test-database: test-deps
	@echo "🧪 Running database tests..."
	pytest tests/test_database.py -v -m "not slow"

# Run update tests
test-updates: test-deps
	@echo "🧪 Running update tests..."
	pytest tests/test_updates.py -v

# Run tests with coverage
coverage: test-deps
	@echo "📊 Running tests with coverage..."
	pytest tests/ --cov=pyUltroid --cov-report=html --cov-report=term-missing --cov-fail-under=70
	@echo "📊 Coverage report available at htmlcov/index.html"

# Lint code
lint:
	@echo "🔍 Running linting checks..."
	python -m flake8 pyUltroid/ plugins/ --max-line-length=88 --ignore=E203,W503,F401
	python -m pylint pyUltroid/ --disable=C0114,C0115,C0116,R0903,R0913

# Format code
format:
	@echo "✨ Formatting code..."
	python -m black pyUltroid/ plugins/ tests/ --line-length=88
	python -m isort pyUltroid/ plugins/ tests/ --profile=black

# Run all quality checks
check: lint
	@echo "✅ Running all quality checks..."
	python -m mypy pyUltroid/ --ignore-missing-imports

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	rm -rf .pytest_cache .coverage htmlcov/ .mypy_cache
	@echo "✅ Cleanup complete!"

# Quick test for specific component
test-quick:
	@echo "🚀 Quick test runner available:"
	@echo "Usage: python quick_test.py [component]"
	@echo "Example: python quick_test.py core"

# Test with specific markers
test-unit:
	pytest tests/ -m "unit" -v

test-integration:
	pytest tests/ -m "integration" -v

test-slow:
	pytest tests/ -m "slow" -v

# Development setup
dev-setup: install test-deps
	@echo "🔧 Development environment setup complete!"
	@echo "💡 Run 'make test' to verify everything works"

# CI/CD simulation
ci: test-deps lint test coverage
	@echo "🎯 CI/CD checks complete!"
