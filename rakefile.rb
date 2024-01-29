# this project may be viewed here: https://lou-parslow.github.io/NasaData/
NAME = "NasaData"
VERSION = "0.0.0"
require "raykit"
GITHUB_PAGES_DIR = "docs"

task :setup do
  run "dotnet new fluentblazorwasm -o src/#{NAME} -n #{NAME}" unless Dir.exist? "src/#{NAME}"
end

task :build do
  try "rufo ."
  run "dotnet publish src/#{NAME}/#{NAME}.csproj -c Release -o artifacts/#{NAME}.#{VERSION}"
  FileUtils.cp_r "artifacts/#{NAME}.#{VERSION}/wwwroot/.", GITHUB_PAGES_DIR
  File.open("#{GITHUB_PAGES_DIR}/.nojekyll", "w") { }
  Raykit::Text::replace_in_file("#{GITHUB_PAGES_DIR}/index.html", '<base href="/" />', '<base href="/NasaData/" />')
end

task :default => [:build, :integrate, :push] do
end

task :update_docs => [:build] do
  #SITE_DIR="artifacts/#{NAME}.#{VERSION}"
  #FileUtils.cp("README.md","src/Hello.Blazor.Wasm/wwwroot/")
  #FileUtils.mkdir("artifacts") unless Dir.exist? "artifacts"
  #FileUtils.mkdir(SITE_DIR) unless Dir.exist? SITE_DIR
  #puts "  copying files to #{SITE_DIR}"
  #FileUtils.cp_r "dist/wwwroot/.", SITE_DIR
  # for github pages, a .nojekyll file is required to prevent github from ignoring files starting with an underscore
  #File.open("#{SITE_DIR}/.nojekyll", "w") { }
  #Raykit::Text::replace_in_file("#{SITE_DIR}/index.html", '<base href="/" />', '<base href="/Hello.Blazor.Wasm/" />')
  #mkdir "docs" unless Dir.exist? "docs"
  #FileUtils.cp_r "#{SITE_DIR}/.", "docs"
end
