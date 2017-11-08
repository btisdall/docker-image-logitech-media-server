.PHONY: update-download-url

update-download-url:
	URL=$$(curl -s "http://www.mysqueezebox.com/update/?version=7.9.1&revision=1&geturl=1&os=deb" | sed "s/all/amd64/"); \
  gsed -i -e "s!PACKAGE_VERSION_URL\=.*!PACKAGE_VERSION_URL=$${URL}!" Dockerfile
