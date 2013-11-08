# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fix_iphone_picture_orientation/version'

Gem::Specification.new do |spec|
  spec.name          = "fix_iphone_picture_orientation"
  spec.version       = FixIphonePictureOrientation::VERSION
  spec.authors       = ["Tamara Temple"]
  spec.email         = ["tamouse@gmail.com"]
  spec.description   = %q{Convert iPhone images to have a useful Orientation tag value
and be internally correctly oriented.

The iPhone has used the EXIF tag Orientation to store the actual
orientation of the camera. A lot of programs and libraries don't
seem to understand this, especially online photo galleries such
as Flickr and Gallery.

This program will modify the image to rotate it internally according
to the iPhone's orientation value, and then set the EXIF orientation
tag to "Horizontal (normal)" thus removing the confusion.
}
  spec.summary       = %q{Convert iPhone images to proper internal orientation and change Orientation tag to Horizontal}
  spec.homepage      = "http://github.com/tamouse/fix_iphone_orientation.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'methadone', '~> 1.3.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-cucumber'
  spec.add_development_dependency 'guard-bundler'

end
