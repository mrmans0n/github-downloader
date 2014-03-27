require 'github_downloader/version'
require 'fileutils'
require 'rubygems'
require 'optparse'
require 'pathname'
require 'securerandom'
require 'net/http'
require 'uri'
require 'github_api'
require 'github_downloader/parser'
require 'github_downloader/string'

module GithubDownloader

  def self.show_error(error_string)
    puts 'Error!'.red
    puts error_string
    exit
  end

  def self.run(command)
    output = `#{command} 2> github_downloader_error.log`
    if $?.exitstatus > 0
      print "Failed!\n".red
      puts output
      exit(-1)
    else
      print "Done!\n".green
    end
  end

  def self.from_cmdline(args)
    show_error 'no options specified, try with --help and see all the available options' unless ARGV.size > 0

    options = Parser.new do |p|
      p.banner = 'GitHub Repo Downloader'
      p.version = VERSION
      p.option :username, 'Your GitHub user', :default => '', :short => 'u'
      p.option :password, 'Your GitHub password', :default => '', :short => 'p'
      p.option :organization, 'GitHub Organization (optional)', :default => '', :short => 'g'
      p.option :from, 'GitHub user from which we want to download (optional)', :default => '', :short => 'r'
      p.option :output, 'Output directory', :default => '.', :short => 'o'
    end.process!

    show_error 'no user specified, please check --help to see all available options' if options[:username].blank?
    show_error 'no password specified, please check --help to see all available options' if options[:password].blank?
    if (options[:organization].blank? && options[:from].blank?) || (!options[:organization].blank? && !options[:from].blank?)
      show_error 'either an organization or an user must be provided to download repositories, not both or none'
    end

    output_dir = options[:output]
    user = options[:username]
    pass = options[:password]
    organization = options[:organization]
    user_repo = options[:from]

    github = Github.new basic_auth: "#{user}:#{pass}" do |config|
      config.org = organization unless organization.blank?
      config.auto_pagination = true
    end

    FileUtils.makedirs output_dir if output_dir != '.'

  # Either chose repos from an organization or an user
    all_repos = github.repos.all unless organization.blank?
    all_repos = github.repos.list user: user_repo unless user_repo.blank?

    all_repos.each do |repo|
      print "Downloading archive for #{repo.full_name}... "
      Dir.chdir output_dir do
        run "curl -i -u #{user}:#{pass} -o #{repo.name}-master-archived.zip -L #{repo.html_url}/archive/master.zip"
      end
    end
  end
end
