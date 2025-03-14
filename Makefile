GEMFURY_AUTH_TOKEN := ${GEMFURY_AUTH_TOKEN}

# distribution details
VERSION := $(shell awk '$$1 == "__version__" {print $$NF}' ./deming/_version.py)
OS := none
CPU_ARCH = any

help:
	@echo "Deming-core Makefile Help:\n"\
	"clean:  Remove all cache and wheel packages.\n"\
	"build:  Build deming-core wheel package via setup.py.\n"\
	"version:  Show current deming-core version.\n"\
	"publish:  Upload the package in dist directory that matches current deming-core version.\n"\
	" VERSION Specify another version to upload (If there is one avaliable). "

clean-dist:
	rm -r ./dist 2>/dev/null || true

clean-cache:
	rm -r *.egg-info || true
	python3 setup.py clean --all || true

clean: clean-dist clean-cache

obfuscate:
	./code_obfuscation.py

build: clean
	 python setup.py bdist_wheel

version:
	@echo $(VERSION)

publish: override VERSION := $(if $(VERSION),$(VERSION),)
publish: WHEEL_FILENAME := deming_core-$(VERSION)-py3-$(OS)-$(CPU_ARCH).whl
publish:
	curl -F package=@dist/$(WHEEL_FILENAME) https://$(GEMFURY_AUTH_TOKEN)@push.fury.io/quartic-ai/
