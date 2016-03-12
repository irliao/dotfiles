desc "Compile scripts to .scpt files"
task :compile do
  Dir["*.applescript"].each do |script|
    script_name = script.gsub(/\.applescript/, '')
    puts "Compiling #{script_name}.applescript..."
    system "osacompile -o #{script_name}.scpt #{script_name}.applescript"
  end
  puts "Done"
  puts
end

desc "Install scripts to your scripts folder"
task :install => :compile do
  puts "Copying scripts to your scripts folder"
  system "mkdir -p ~/Library/Scripts"
  system "cp *.scpt ~/Library/Scripts"
  puts "Done"
  puts
end

desc "Download and mount FastScripts"
task :install_fastscripts do
  system "curl http://www.red-sweater.com/fastscripts/FastScriptsLite2.3.6.dmg > FastScripts.dmg"
  system "hdiutil attach FastScripts.dmg"
  puts "FastScripts Lite is now mounted in your system. Opening the folder..."
  sleep 1
  system "open \"/Volumes/FastScripts Lite 2.3.6\""
end