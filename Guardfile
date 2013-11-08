guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard 'cucumber', cli: "--format pretty" do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  watch(%r{^bin/fix_iphone_picture_orientation}) {'features'}
end

guard :rspec, all_on_start: true, all_after_pass: true, cmd: "bundle exec rspec -f doc -c" do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

