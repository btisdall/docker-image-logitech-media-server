.PHONY: update-download-url
update-download-url:
	URL=$$(curl -s "http://www.mysqueezebox.com/update/?version=7.9.3&revision=1&geturl=1&os=deb" | sed "s/all/amd64/"); \
  gsed -i -e "s!PACKAGE_VERSION_URL\=.*!PACKAGE_VERSION_URL=$${URL}!" Dockerfile

.PHONY: tag
tag: update-download-url
	@git commit Dockerfile -m "Update version"
	@TAG=$$(grep ^'ENV PACKAGE_VERSION_URL' Dockerfile|awk -F/ '{print $$NF}'|cut -d_ -f2|sed 's/~/-/g')-ubuntu-14.04; echo $$TAG; git tag $$TAG

.PHONY: push
push: tag
	@git push --tags
