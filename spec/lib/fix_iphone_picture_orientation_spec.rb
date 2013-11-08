require 'spec_helper'
require 'fileutils'

module FixIphonePictureOrientation
  
  describe "Version" do
    it{FixIphonePictureOrientation::VERSION.should_not be_nil}
  end

  describe FixIphonePictureOrientation do
    let(:dir){File.expand_path("../../support/test_data",__FILE__)}
    before do
      Dir.chdir(dir) do |dir|
        FileUtils.rm(Dir["*"])
        system "convert rose: test1.jpg"
        system "exiftool -ORIENTATION=\"Horizontal (normal)\" test1.jpg >/dev/null"
        system "convert rose: test2.jpg"
        system "exiftool -ORIENTATION=\"Rotate 90 CW\" test2.jpg >/dev/null"
        system "convert rose: test3.jpg"
        system "exiftool -ORIENTATION=\"Rotate 180\" test3.jpg >/dev/null"
        system "convert rose: test4.jpg"
        system "exiftool -ORIENTATION=\"Rotate 270 CW\" test4.jpg >/dev/null"
        FileUtils.rm(Dir["*_original"])
      end
    end

    it "dir should exist" do
      Dir.exists?(dir).should be_true
    end

    context "file_list" do
      let(:result){FixIphonePictureOrientation.file_list(dir)}
      let(:expected){%w[test1.jpg test2.jpg test3.jpg test4.jpg]}
      it{result.length.should eq 4}
      it "should return expected list of files" do
        (result-expected).should be_empty
      end

    end

    context "build_work_list" do
      let(:result){FixIphonePictureOrientation.build_work_list(dir)}
      let(:expected){%w[test2.jpg test3.jpg test4.jpg]}
      it{result.should be_an Array}
      it{result.length.should eq 3}
      it "should return only the non-horizontal files" do
        (result.map(&:SourceFile)-expected).should be_empty
      end
    end

    context "rotate_pictures" do
      let(:list){FixIphonePictureOrientation.build_work_list(dir)}
      let(:result){FixIphonePictureOrientation.rotate_pictures(dir,list)}
      it{result.should be_empty}
    end

    context "run" do
      let(:result){FixIphonePictureOrientation.run(dir)}
      it{result.should be_true}
    end
  end
  
end
