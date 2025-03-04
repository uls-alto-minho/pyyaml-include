.PHONY: docs tests src

setup-dev:
	pip3 install -e .[dev,test]

setup-ci:
	pip3 install -e .[test,docs,ci]

test:
	pytest .

dev:
	ptw

coverage:
	coverage run -m pytest

report-coverage: coverage
	coverage html

badge-coverage: coverage
	mkdir -p docs/badges
	coverage-badge -f -o docs/badges/coverage.svg

docs-build: badge-coverage report-coverage
	mkdocs build

docs-deploy:
	mike deploy --push $(cat VERSION) --allow-empty