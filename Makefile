# Ensure pip is upgraded and install all required packages
install:
	pip install --upgrade pip && pip install -r requirements.txt

# Setup the virtual environment
setup:
	python3 -m venv venv
	@echo "Virtual environment created. Activate with: 'source venv/bin/activate'"
	. venv/bin/activate && pip install --upgrade pip

# Run tests within the virtual environment
test:
	. venv/bin/activate && PYTHONPATH=. pytest tests/ 

# Lint the source code and tests
lint:
	. venv/bin/activate && ruff check main.py tests

# Format all Python files
format:
	. venv/bin/activate && black .

# Clean the virtual environment
clean:
	rm -rf venv

# Run the application with messages
run:
	. venv/bin/activate && python main.py

# Run all major tasks: install, setup, lint, test, format
all: install setup lint test format

# Docker build and run commands
docker-build:
	docker build -t ip3 .

docker-run:
	docker run -it --rm --network="host" ip3

docker-test:
	docker run -it --rm --network="host" ip3 pytest tests/


# Clean up Docker containers and images
docker-clean:
	docker system prune -f
	docker rmi ip3
