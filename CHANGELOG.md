# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.2.0](https://github.com/voxpupuli/puppet-alternatives/tree/v4.2.0) (2022-09-20)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v4.1.0...v4.2.0)

**Implemented enhancements:**

- Allow family to be used instead of full path [\#127](https://github.com/voxpupuli/puppet-alternatives/pull/127) ([alexjfisher](https://github.com/alexjfisher))

**Fixed bugs:**

- Fixes multiple expressions in case statement [\#124](https://github.com/voxpupuli/puppet-alternatives/pull/124) ([otterz](https://github.com/otterz))

**Closed issues:**

- Could not determine mode after upgrade to 4.1.0 [\#123](https://github.com/voxpupuli/puppet-alternatives/issues/123)
- Using a full path for path is not always desirable. [\#71](https://github.com/voxpupuli/puppet-alternatives/issues/71)

**Merged pull requests:**

- Add basic acceptance tests [\#126](https://github.com/voxpupuli/puppet-alternatives/pull/126) ([jhoblitt](https://github.com/jhoblitt))

## [v4.1.0](https://github.com/voxpupuli/puppet-alternatives/tree/v4.1.0) (2022-05-13)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- Add CentOS 8 support [\#121](https://github.com/voxpupuli/puppet-alternatives/pull/121) ([bastelfreak](https://github.com/bastelfreak))

## [v4.0.0](https://github.com/voxpupuli/puppet-alternatives/tree/v4.0.0) (2021-11-26)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v3.0.0...v4.0.0)

**Breaking changes:**

- Drop support for Puppet 5 \(EOL\) [\#113](https://github.com/voxpupuli/puppet-alternatives/pull/113) ([smortex](https://github.com/smortex))
- Drop support for Debian 8, 9; RedHat 6 and derivatives \(EOL\) [\#112](https://github.com/voxpupuli/puppet-alternatives/pull/112) ([smortex](https://github.com/smortex))
- drop Ubuntu support [\#98](https://github.com/voxpupuli/puppet-alternatives/pull/98) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add support for Debian 11, Ubuntu 18.04 and 20.04 [\#115](https://github.com/voxpupuli/puppet-alternatives/pull/115) ([smortex](https://github.com/smortex))
- Add support for Puppet 7 [\#114](https://github.com/voxpupuli/puppet-alternatives/pull/114) ([smortex](https://github.com/smortex))
- renamed provider to fit current status of alternative usage in distributions / Add SLES12/15 support [\#101](https://github.com/voxpupuli/puppet-alternatives/pull/101) ([pseiler](https://github.com/pseiler))
- add Debian working versions to metadata [\#97](https://github.com/voxpupuli/puppet-alternatives/pull/97) ([trefzer](https://github.com/trefzer))

**Closed issues:**

- SLES 12 and 15 do not work with puppet-alternatives [\#105](https://github.com/voxpupuli/puppet-alternatives/issues/105)
- check debian support [\#78](https://github.com/voxpupuli/puppet-alternatives/issues/78)

**Merged pull requests:**

- Remove duplicate CONTRIBUTING.md file [\#99](https://github.com/voxpupuli/puppet-alternatives/pull/99) ([dhoppe](https://github.com/dhoppe))

## [v3.0.0](https://github.com/voxpupuli/puppet-alternatives/tree/v3.0.0) (2019-03-03)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v2.1.0...v3.0.0)

**Breaking changes:**

- modulesync 2.5.1 & drop Puppet 4 [\#92](https://github.com/voxpupuli/puppet-alternatives/pull/92) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- handle broken alternatives entries more gracefully [\#91](https://github.com/voxpupuli/puppet-alternatives/pull/91) ([fraenki](https://github.com/fraenki))
- Fix mode detection for rpm provider [\#87](https://github.com/voxpupuli/puppet-alternatives/pull/87) ([treydock](https://github.com/treydock))

**Closed issues:**

- Could not determine auto or manual mode [\#80](https://github.com/voxpupuli/puppet-alternatives/issues/80)
- missing alternatives is not added - it breaks instead [\#54](https://github.com/voxpupuli/puppet-alternatives/issues/54)

## [v2.1.0](https://github.com/voxpupuli/puppet-alternatives/tree/v2.1.0) (2018-10-14)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v2.0.1...v2.1.0)

**Implemented enhancements:**

- seting multiple alternatives to the same path [\#41](https://github.com/voxpupuli/puppet-alternatives/issues/41)

**Fixed bugs:**

- alternative\_entry keying to the wrong parameter? [\#40](https://github.com/voxpupuli/puppet-alternatives/issues/40)
- Added namevar to altlink to create a composite namevar name:altlink. [\#75](https://github.com/voxpupuli/puppet-alternatives/pull/75) ([Raskil](https://github.com/Raskil))

**Merged pull requests:**

- modulesync 2.1.0 and allow puppet 6.x [\#85](https://github.com/voxpupuli/puppet-alternatives/pull/85) ([Dan33l](https://github.com/Dan33l))
- Remove docker nodesets [\#79](https://github.com/voxpupuli/puppet-alternatives/pull/79) ([bastelfreak](https://github.com/bastelfreak))
- drop EOL OSs; fix puppet version range [\#76](https://github.com/voxpupuli/puppet-alternatives/pull/76) ([bastelfreak](https://github.com/bastelfreak))

## [v2.0.1](https://github.com/voxpupuli/puppet-alternatives/tree/v2.0.1) (2018-04-03)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v2.0.0...v2.0.1)

**Merged pull requests:**

- bump puppet to latest supported version 4.10.0 [\#73](https://github.com/voxpupuli/puppet-alternatives/pull/73) ([bastelfreak](https://github.com/bastelfreak))
- Add support for Puppet 5 [\#69](https://github.com/voxpupuli/puppet-alternatives/pull/69) ([juniorsysadmin](https://github.com/juniorsysadmin))

## [v2.0.0](https://github.com/voxpupuli/puppet-alternatives/tree/v2.0.0) (2017-11-15)

[Full Changelog](https://github.com/voxpupuli/puppet-alternatives/compare/v1.1.0...v2.0.0)

**Closed issues:**

- plugin sync error? [\#39](https://github.com/voxpupuli/puppet-alternatives/issues/39)
- How does one set alternative entry back to 'auto' mode? [\#32](https://github.com/voxpupuli/puppet-alternatives/issues/32)

**Merged pull requests:**

- Fix github license detection [\#62](https://github.com/voxpupuli/puppet-alternatives/pull/62) ([alexjfisher](https://github.com/alexjfisher))

## [v1.1.0](https://github.com/voxpupuli/puppet-alternatives/tree/v1.1.0) (2017-02-10)

This is the last release with Puppet3 support!
* Modulesync with latest Vox Pupuli defaults

## 2016-12-25 Release 1.0.2

* Modulesync with latest Vox Pupuli defaults
* Fix ALT_RPM_QUERY_REGEX to catch all entries and not only the default ones
* Add Spectest for rpm provider

## 2016-08-12 Release 1.0.1

* Modulesync with latest Vox Pupuli defaults
* Drop of ruby183 support
* new aternative_entry with rpm provider
* Enable explicitly setting mode property to manual
* First release under the Voxpupuli namespace! Migrated from Adrien Thebo
* Rerelease of 1.0.0, which didn't make it to the forge


## 2014-12-19 Release 0.3.0

* New RPM based providers for alternatives and alternative_entry
* Debian based distributions use `update-alternatives` based on $PATH
* The alternatives type now autorequires matching alternate_entry types
* dpkg provider explicitly sets the mode property to manual
* alternative_entry can check for alernative entries for a non-existent entry


## 2014-08-21 Release 0.2.0

* New type: alternative_entry
* The alternatives type now has the `mode` property to use the automatic
    option for a given alternative.
* The update-alternatives binary is no longer hardcoded to use
    /usr/sbin/update-alternatives

### Thanks

Thanks to Michael Moll and jakov Sosic for their work on this release.


## 2013-07-16 Release 0.1.1

This is a backwards compatible bugfix release.

* Module rebuilt with correct permissions.


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
