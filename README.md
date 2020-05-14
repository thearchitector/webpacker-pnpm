# webpacker-pnpm

![version](https://img.shields.io/gem/v/webpacker-pnpm?label=version&style=flat-square)
[![status](https://img.shields.io/travis/thearchitector/webpacker-pnpm?style=flat-square)](https://travis-ci.org/github/thearchitector/webpacker-pnpm)
![downloads](https://img.shields.io/gem/dt/webpacker-pnpm?style=flat-square)
[![license](https://img.shields.io/badge/license-CC--BY--NC--SA--4.0-green?style=flat-square)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

`webpacker-pnpm` replaces Rails' Yarn environment with [pnpm](https://pnpm.js.org/), which is a much smarter, efficient, and faster alternative Node.js package manager. You can read about the philosophy and technology behind `pnpm` in [this convincing blog post](https://www.kochan.io/nodejs/why-should-we-use-pnpm.html) by Zoltan Kochan, but in essence it reduces dependency resolution times and `node_modules` folder sizes to within reasonable ranges (not 30 seconds and 10 GiB).

## Features

- Production-ready
- Drop-in seamless replacement for Yarn, no config required
- Supports Rails' Template API, including existing templates using Yarn
- Independent of official Webpacker versions
- Provides code sanity without the migraines
- Gives you more disk space

## Installation

In order to use `webpacker-pnpm`, you must install `pnpm`. The official instructions are [here](https://pnpm.js.org/en/installation), but all they say is to run the following command:

```sh
$ curl -L https://raw.githubusercontent.com/pnpm/self-installer/master/install.js | node
```

After installing `pnpm`, simply add `webpacker-pnpm` to your app's `Gemfile`. There is no need to worry about your official Webpacker gem version, as this gem should be version-agnostic.

```ruby
gem "webpacker-pnpm"
```

## License

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/> or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
