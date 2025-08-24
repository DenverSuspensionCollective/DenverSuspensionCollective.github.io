export JEKYLL_ENV=development

.DEFAULT: build

# ==== Building The Site ==== #

.PHONY: build
build:
	bundle exec jekyll build

.PHONY: watch
watch:
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
update: update-bundle update-npm

.PHONY: update-bundle
update-bundle:
	bundle update --all
	bundle update --bundler

.PHONY: update-npm
update-npm:
	npm update

# ==== Adding Meets ==== #
.PHONY: monthly-meet
monthly-meet:
	bundle exec ruby ./scripts/add_monthly_meet.rb --start_date "$(date)" --location "$(loc)"
