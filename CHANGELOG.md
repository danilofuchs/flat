# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2023-11-07

- **feat:** `unflatten` function. Thanks [@Pana-g](https://github.com/Pana-g) ([#9](https://github.com/danilofuchs/flat/pull/9))

## [0.4.1] - 2021-11-18

- **fix:** `type 'List<dynamic>' is not a subtype of type 'List<Object>' in type cast` when flattening a JSON decoded object

## [0.4.0] - 2020-03-26

### Breaking Change

The library now uses `Map<String, dynamic>` instead of `Map<String, Object>`.

This means null values are now accepted inside the map, following Dart null-safety
guidelines. This is specially important when dealing with JSON objects.

- **feat:** `Map<String, dynamic>` instead of `Map<String, Object>`

## [0.3.0] - 2020-03-12

- **feat:** Stable Null Safety support (requires Dart >= 2.12.0)

## [0.3.0-nullsafety.0] - 2020-11-30

- **feat:** Null Safety support (requires Dart >= 2.12.0-0)

## [0.2.0] - 2020-02-22

- **chore:** Enable effective_dart linting rules
- **feat:** maxDepth parameter
- **fix:** Preserve empty Maps
- **refactor:** Simplify logic based on npm's flat

## [0.1.1] - 2020-02-20

- **chore:** Simple example project
- **chore:** API docs

## [0.1.0] - 2020-02-20

- **feat:** delimiter override option
- **feat:** safe mode to avoid flattening lists
- **feat:** Ability to flatten lists (which can contain maps)
- **feat:** Ability to flatten nested maps
- **feat:** `flatten` method basic implementation
