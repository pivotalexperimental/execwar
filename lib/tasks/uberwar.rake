require 'warbler'
require 'jruby-jars'

namespace :uberwar do
  desc "Package an executable jar with compiled ('obfuscated') rails app classes, leveraging warbler"
  task :build => ["war:clean", "war:app", "war:public", "war:webxml"] do
  
    # Compile Java classes with javac
    javac_target_path = "#{RAILS_ROOT}/tmp/war"
    javac_source_path = "#{RAILS_ROOT}/app/java"
    
    javac_classpath = Dir.glob("#{RAILS_ROOT}/lib/java/jetty/*.jar")
    javac_classpath += FileList[
      "#{Warbler::WARBLER_HOME}/lib/*.jar",
      JRubyJars.core_jar_path,
      JRubyJars.stdlib_jar_path
    ]
    
    # extract classes from dependency library jars
    javac_classpath.each do |jar|
      extract_cmd = "cd #{javac_target_path} && jar -xf #{jar}"
      puts "Extracting jar: '#{extract_cmd}'"
      system(extract_cmd) || raise("Error extracting jar file '#{jar}'")
    end
    
    # delete signature files from extracted jars' manifests
    FileUtils.rm_rf Dir.glob("#{javac_target_path}/META-INF/ECLIPSE*")
    FileUtils.rm_rf Dir.glob("#{javac_target_path}/META-INF/eclipse*")
    
    java_classes_to_compile = Dir.glob("#{RAILS_ROOT}/app/java/**/*.java")
    
    java_compile_cmd = "cd #{javac_source_path} && javac -cp #{javac_classpath.join(':')} -d #{javac_target_path} #{java_classes_to_compile.join(' ')}"
    puts  "Compiling with javac: '#{java_compile_cmd}'"
    system(java_compile_cmd) || raise("Error compiling java classes")

    # Compile the Ruby classes with jrubyc
    war_files_path = "#{RAILS_ROOT}/tmp/war/WEB-INF"
    dirs_to_compile = [
        "app",
        "lib"
    ]

    jruby_compile_cmd = "cd #{war_files_path} && jruby -S jrubyc #{dirs_to_compile.join(' ')}"
    puts  "Compiling with jrubyc: '#{jruby_compile_cmd}'"
    system(jruby_compile_cmd) || raise("Error compiling jruby")

    ## remove compiled .rb files
    files_to_delete = dirs_to_compile.map {|dir| Dir.glob("#{war_files_path}/#{dir}/**/*.rb")}.flatten
    FileUtils.rm_f(files_to_delete)

  	#create 00_jruby_compiled initializer to active compiled jruby setup for deployed war file
  	File.open("#{war_files_path}/config/initializers/00_jruby_compiled.rb", 'w') {|f| f.puts 'JRUBY_COMPILED_WAR = true'}

  	#package js and css files in war
  	war_js_dir = "#{RAILS_ROOT}/tmp/war/javascripts"
  	war_css_dir = "#{RAILS_ROOT}/tmp/war/stylesheets"
  	FileUtils.mkdir_p(war_js_dir)
  	FileUtils.mkdir_p(war_css_dir)
  	FileUtils.mv(Dir.glob("#{RAILS_ROOT}/public/javascripts/*_?[^a-z]*[^a-z].js"), war_js_dir)
  	FileUtils.mv(Dir.glob("#{RAILS_ROOT}/public/stylesheets/*_?[^a-z]*[^a-z].css"), war_css_dir)

  	#remove 
    Rake::Task["war:jar"].invoke
    # FileUtils.rm_rf("#{RAILS_ROOT}/tmp/war")
  end
end