# Websocket::Echo::Io

[![ruby-tests](https://github.com/akostadinov/websocket-echo-io/actions/workflows/main.yml/badge.svg)](https://github.com/akostadinov/websocket-echo-io/actions/workflows/main.yml)
[![image-build](https://github.com/akostadinov/websocket-echo-io/actions/workflows/container-image-buildah.yml/badge.svg)](https://github.com/akostadinov/websocket-echo-io/actions/workflows/container-image-buildah.yml)
[![coverage](https://akostadinov.github.io/websocket-echo-io/badge.svg)](https://akostadinov.github.io/websocket-echo-io/)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add websocket-echo-io

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install websocket-echo-io

## Usage

```
$ websocket-echo-io
```

## Usage as a container

```
$ podman run --rm -p 3003:3003 ghcr.io/akostadinov/websocket-echo-io:latest
```

## Access the public service

```
ws://websocket-echo-intustack.koyeb.app
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akostadinov/websocket-echo-io. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/akostadinov/websocket-echo-io/blob/main/CODE_OF_CONDUCT.md).

## Release checklist

- update `lib/websocket/echo/io/version.rb`
- `gem build websocket-echo-io.gemspec`
- create a github release and tag
- deploy to koyeb.com unless using a moving tag there already

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Websocket::Echo::Io project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/akostadinov/websocket-echo-io/blob/main/CODE_OF_CONDUCT.md).
