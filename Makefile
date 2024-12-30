export JEKYLL_ENV=development

.DEFAULT: build

# ==== Building The Site ==== #

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: watch
incr:
	bundle exec jekyll build
	bundle exec jekyll build --watch --incremental

.PHONY: preview
preview:
	bundle exec jekyll serve --watch

# ==== Installation ==== #

.PHONY: install
install:
	bundle install
	npm install

# ==== Updating Dependencies ==== #

.PHONY: update
update: update-bundle update-deps

.PHONY: update-bundle
update-bundle:
	bundle update --all
	bundle update --bundler

.PHONY: update-deps
update-deps:
	npm update
