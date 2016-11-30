require 'fileutils'

PACKAGENAME = "maxmanage"
VERSION = "0.1.4"
TRAVELING_RUBY_VERSION = "20150715-2.2.2"


namespace :maxmanage do
  desc "Build travelling ruby version of maxjsonapi"
  task package: [:environment,
      "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86_64.tar.gz",
      "packaging/traveling-ruby-gems-#{TRAVELING_RUBY_VERSION}-linux-x86_64-nokogiri-1.6.6.2.tar.gz" 
  ] do
    if RUBY_VERSION !~ /^2\.2\.2/
      abort "You can only 'bundle install' using Ruby 2.2.2, because that's what Traveling Ruby uses."
    end
    sh "rm -rf packaging/tmp"
    sh "mkdir packaging/tmp"
    sh "cp Gemfile packaging/tmp/"
    sh "cp Gemfile.lock packaging/tmp/"
    Bundler.with_clean_env do
      sh "cd packaging/tmp && env BUNDLE_IGNORE_CONFIG=1 bundle install --path ../vendor --without development"
    end
    sh "rm -rf packaging/tmp"
    sh "rm -f packaging/vendor/*/*/cache/*"
    sh "rm -rf packaging/vendor/ruby/*/extensions"
    sh "find packaging/vendor/ruby/*/gems -name '*.so' | xargs rm -f"
    sh "find packaging/vendor/ruby/*/gems -name '*.bundle' | xargs rm -f"
    sh "find packaging/vendor/ruby/*/gems -name '*.o' | xargs rm -f"
    create_package("linux-x86_64")
  end

  desc "TODO"
  task clean: :environment do
    sh "rm -f *.tar.gz"
    sh "rm -f packaging/*.tar.gz"
  end

  desc "Tag github release and upload file."
  task release: :environment do
    gh = Octokit::Client.new(access_token: ENV['MAXMANAGE_GITHUB_TOKEN'])
    repo = 'skord/maxjsonapi'
    ref = 'heads/master'
    latest_commit = gh.ref(repo,ref).object.sha
    release = gh.create_release(repo,"v#{VERSION}")
    asset = gh.upload_asset(release[:url], "maxmanage-#{VERSION}-linux-x86_64.tar.gz")
  end

  desc "Docker Image Build"
  task docker_build: :environment do
    puts "Writing version to Dockerfile.package"
    dockerfile = File.read("Dockerfile.package")
    new_file = File.open("Dockerfile.package", "w") do |file|
      file << dockerfile.
                gsub(/MAXMANAGE_VERSION=[\d\.]{1,}/, "MAXMANAGE_VERSION=#{VERSION}").
                gsub(/Version=[\d\.]{1,}/, "Version=#{VERSION}")
    end
    puts "tagging docker images"
    sh "docker build -t skord/maxmanage:latest -f Dockerfile.package ."
    sh "docker tag skord/maxmanage:latest skord/maxmanage:#{VERSION}"
  end

  desc "Docker image push"
  task docker_push: :environment do
    sh "docker push skord/maxmanage:latest"
    sh "docker push skord/maxmanage:#{VERSION}"
  end
  
  file "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86_64.tar.gz" do
    download_runtime("linux-x86_64")
  end

  file "packaging/traveling-ruby-gems-#{TRAVELING_RUBY_VERSION}-linux-x86_64-nokogiri-1.6.6.2.tar.gz" do
    download_native_extension("linux-x86_64","nokogiri-1.6.6.2")
  end

  def create_package(target)
    package_dir = "#{PACKAGENAME}-#{VERSION}-#{target}"
    sh "rm -rf #{package_dir}"
    sh "mkdir #{package_dir}"
    sh "mkdir -p #{package_dir}/lib/app"
    assets = Dir.glob('*') - ['packaging', package_dir]
    FileUtils.cp_r(assets, "#{package_dir}/lib/app")
    sh "mkdir #{package_dir}/lib/ruby"
    sh "tar -xzf packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz -C #{package_dir}/lib/ruby"
    sh "cp packaging/wrapper.sh #{package_dir}/maxmanage"
    sh "cp -pR packaging/vendor #{package_dir}/lib/"
    sh "cp Gemfile #{package_dir}/lib/vendor/"
    sh "cp Gemfile.lock #{package_dir}/lib/vendor/"
    sh "mkdir #{package_dir}/lib/vendor/.bundle"
    sh "cp packaging/bundler-config #{package_dir}/lib/vendor/.bundle/config"
    sh "tar -xzf packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}-nokogiri-1.6.6.2.tar.gz -C #{package_dir}/lib/vendor/ruby"
    if !ENV['DIR_ONLY']
      sh "tar -czf #{package_dir}.tar.gz #{package_dir}"
      sh "rm -rf #{package_dir}"
    end
  end

  def download_runtime(target)
    sh "cd packaging && curl -L -O --fail " +
      "https://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz"
  end

  def download_native_extension(target, gem_name_and_version)
    sh "curl -L --fail -o packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}-#{gem_name_and_version}.tar.gz " +
    "https://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-gems-#{TRAVELING_RUBY_VERSION}-#{target}/#{gem_name_and_version}.tar.gz"
  end
end
