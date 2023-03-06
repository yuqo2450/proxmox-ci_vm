# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [v0.4.1] - 2023-03-06

### Changed

* Increased balloon size to avoid VM running out of memory when proxmox metrics are high

## [v0.4.0] - 2022-01-08

### Added

* Added an example how to use this module
* Added variable to set a MAC address prefix

### Changed

* Split code into multiple files
* userdata_vars is now optional
* Variable interfaces is now of type map(map(string))

### Removed

* Removed variable ip4_addresses

[v0.4.0]: https://github.com/yuqo2450/tf_pmx_vm_base/compare/v0.3.1...v0.4.0
[v0.4.1]: https://github.com/yuqo2450/tf_pmx_vm_base/compare/v0.4.0...v0.4.1
