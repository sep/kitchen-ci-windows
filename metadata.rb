name 'kitchen-ci-windows'
maintainer 'Bob Nowadly'
maintainer_email 'rmnowadly@sep.com'
license 'Apache license 2.0'
description 'Installs/Configures kitchen-ci-windows'
long_description 'Installs/Configures kitchen-ci-windows'
version '0.7.6'

supports 'windows', '2016'

depends 'chocolatey', '~> 1.1.0'
depends 'java-oracle', '~> 0.1.1'
depends 'git-wrapper', '~> 0.1.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/sep/kitchen-ci-windows/issues' if respond_to?('issues_url')

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/sep/kitchen-ci-windows' if respond_to?('source_url')
