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
	. venv/bin/activate && ruff check src tests

# Format all Python files
format:
	. venv/bin/activate && black .

# Clean the virtual environment
clean:
	rm -rf venv

# Run the application with messages
run:
	. venv/bin/activate && python src/cli.py

# Run all major tasks: install, setup, lint, test, format
all: install setup lint test format

# Docker build and run commands
docker-build:
	docker build -t ids706-miniproj6 .

docker-run:
	docker run -it --rm --network="host" ids706-miniproj6

docker-test:
	docker run -it --rm --network="host" ids706-miniproj6 pytest tests/

# MySQL inside the running MySQL container
mysql-cli:
	docker exec -it mysql-db mysql -u root -p

# Clean up Docker containers and images
docker-clean:
	docker system prune -f
	docker rmi ids706-miniproj6
