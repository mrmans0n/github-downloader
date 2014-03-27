# GithubDownloader

A simple gem for bulk downloading all the GitHub repositories you have access to for an user account or an organization account.

It will download all the repositories you have access to with your account.

## Installation

    $ gem install github_downloader

## Usage

Once installed, you can use the gem by typing the command `ghdl` with some parameters.

For a comprehensive help with all available parameters, you should execute:

    $ ghdl --help

An example for downloading all repos for an organization in the current directory:

    $ ghdl -u your_github_user -p your_github_password -g organization_name

An example for downloading all repos of a given user in a specific directory:

    $ ghdl -u your_github_user -p your_github_password -o /an/output/directory/ -r a_github_user

## Contributing

1. Fork it ( http://github.com/mrmans0n/github-downloader/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
