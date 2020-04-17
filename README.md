# webpacker-pnpm

[![version](https://img.shields.io/gem/v/webpacker-pnpm.svg?label=version&style=flat-square)
![downloads](https://img.shields.io/gem/dt/webpacker-pnpm.svg?style=flat-square)](https://rubygems.org/gems/webpacker-pnpm)
![license](https://img.shields.io/badge/license-CC--BY--NC--SA--4.0-green?style=flat-square)

`webpacker-pnpm` replaces Rails' Yarn environment with [pnpm](https://pnpm.js.org/), which is a much smarter, efficient, and faster alternative Node.js package manager. You can read about the philosophy and technology behind `pnpm` in [this convincing blog post](https://www.kochan.io/nodejs/why-should-we-use-pnpm.html) by Zoltan Kochan, but in essence it reduces dependency resolution times and `node_modules` folder sizes to within reasonable ranges.

## Installation

In order to use `webpacker-pnpm`, you must install `pnpm`. The official instructions are [here](https://pnpm.js.org/en/installation), but all they say is to run the following command:

```sh
$ curl -L https://raw.githubusercontent.com/pnpm/self-installer/master/install.s | node
```

After installing `pnpm`, simply add `webpacker-pnpm` to your app's `Gemfile`. The master branch will always be up to date with the latest public release of Webpacker,
but you can select whichever version you desire via the `tag` flag in the gem specification.

```ruby
gem 'rugged', git: 'git://github.com/libgit2/rugged.git', submodules: true
```

## License

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/> or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
