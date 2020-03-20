SRC = $(wildcard ./*.ipynb)

all: testnbdev docs

testnbdev: $(SRC)
	nbdev_build_lib
	touch testnbdev

docs_serve: docs
	cd docs && ip route get 8.8.8.8 | awk 'NR==1 {print $$NF; exit}' | xargs bundle exec jekyll serve -H 

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi
	nbdev_bump_version

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist