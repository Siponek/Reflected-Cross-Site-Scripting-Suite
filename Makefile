VENV := venv-xss
ifeq ($(OS),Windows_NT)
	detected_OS := Windows
	PYTHON := $(VENV)/Scripts/python.exe
	PYTEST := $(PYTHON) -m pytest
	PIP := $(VENV)/Scripts/pip
else
	detected_OS := $(shell uname -s)
	PYTHON := $(VENV)/bin/python
	PIP := $(VENV)/bin/pip
endif


.PHONY: reqs
reqs:
	pipreqs --force --encoding=utf8 ./ --ignore ./$(VENV)/

.PHONY: clean
clean:
	rm -rf ./$(VENV)/

.PHONY: venv
venv:
	python -m venv $(VENV)

.PHONY: install_reqs
install_reqs:
	$(PIP) install -r requirements.txt

.PHONY: build
build:
	docker-compose build

.PHONY: up
up:
	docker-compose up
.PHONY: up-d
up-d:
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: run-behave
run-behave:
	$(PYTHON) -m behave --color