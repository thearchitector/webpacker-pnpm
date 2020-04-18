# webpacker-pnpm

![version](https://img.shields.io/github/v/release/thearchitector/webpacker-pnpm?label=version&style=flat-square)
![status](https://img.shields.io/travis/thearchitector/webpacker-pnpm?style=flat-square)
![license](https://img.shields.io/badge/license-CC--BY--NC--SA--4.0-green?style=flat-square)

`webpacker-pnpm` replaces Rails' Yarn environment with [pnpm](https://pnpm.js.org/), which is a much smarter, efficient, and faster alternative Node.js package manager. You can read about the philosophy and technology behind `pnpm` in [this convincing blog post](https://www.kochan.io/nodejs/why-should-we-use-pnpm.html) by Zoltan Kochan, but in essence it reduces dependency resolution times and `node_modules` folder sizes to within reasonable ranges (not 30 seconds and 10 GiB).

## Installation

In order to use `webpacker-pnpm`, you must install `pnpm`. The official instructions are [here](https://pnpm.js.org/en/installation), but all they say is to run the following command:

```sh
$ curl -L https://unpkg.com/@pnpm/self-installer | node
```

After installing `pnpm`, simply add `webpacker-pnpm` to your app's `Gemfile`. New versions of this gem will come out in parallel with official releases of the Webpacker gem. If you need a different version, you can select whichever version you desire via the `tag` flag in the gem line specification.

```ruby
gem 'webpacker-pnpm', github: 'thearchitector/webpacker-pnpm', submodules: true, tag: 'v1.0.0'
```

## License

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/> or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
