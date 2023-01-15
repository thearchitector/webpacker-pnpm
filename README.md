# webpacker-pnpm

[![version](https://img.shields.io/gem/v/webpacker-pnpm?label=version&style=flat-square)](https://rubygems.org/gems/webpacker-pnpm)
[![status](https://img.shields.io/github/actions/workflow/status/thearchitector/webpacker-pnpm/ci.yaml?label=tests&style=flat-square)](https://travis-ci.org/github/thearchitector/webpacker-pnpm)
[![downloads](https://img.shields.io/gem/dt/webpacker-pnpm?style=flat-square)](https://rubygems.org/gems/webpacker-pnpm)
[![license](https://img.shields.io/github/license/thearchitector/webpacker-pnpm?style=flat-square)](LICENSE)
[![Buy a tree](https://img.shields.io/badge/Treeware-%F0%9F%8C%B3-lightgreen?style=flat-square)](https://ecologi.com/eliasgabriel?r=6128126916bfab8bd051026c)

`webpacker-pnpm` replaces Rails' Yarn environment with [pnpm](https://pnpm.io), a better, smarter, and more efficient Node.js package manager. As a result, applications become less prone to dependency hell, more functional, more stable, and more flexible. And as an added bonus, dependency resolution times and `node_modules` folder sizes reduce to within reasonable ranges (not 45 seconds and 10 GiB).

You can read about the philosophy and technology behind `pnpm` in [this convincing blog post](https://www.kochan.io/nodejs/why-should-we-use-pnpm) by Zoltan Kochan (<https://www.kochan.io/nodejs/why-should-we-use-pnpm>).

## Features

- Production-ready
- Drop-in replacement for Yarn
- Supports Rails' Template API, including existing templates using Yarn
- Provides code sanity without the migraines
- Gives you more disk space

## Installation

In order to use `webpacker-pnpm`, you must install `pnpm`. The official instructions are [here](https://pnpm.io/installation).

After installing `pnpm`, first add `webpacker-pnpm` to your app's `Gemfile`.

```ruby
gem "webpacker-pnpm"
```

Secondly, add the following line to your `./bin/webpack` so it looks like below (the order matters). This step is required as Webpacker spawns a new process isolated from the Rails server (and thus all auto-loaded patches) when compilation happens live.

```ruby
require "webpacker/webpack_runner"
require "webpacker/pnpm/patches" if ENV["RAILS_ENV"] != "production"
```

> _If you know of an automatic way of achieving a similar result, please open an Issue or PR with your suggestion._

## License

This software is licensed under the [BSD 3-Clause License](LICENSE).

This package is Treeware. If you use it in production, consider buying the world a tree to thank me for my work. By contributing to my forest, you’ll be creating employment for local families and restoring wildlife habitats.
