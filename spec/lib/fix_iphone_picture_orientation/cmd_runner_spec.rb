require 'spec_helper'

module FixIphonePictureOrientation

  describe CmdRunner do
    it{should respond_to(:run)}
    context "running a simple command" do
      let(:result){CmdRunner.run('ls')}
      it {result.should be_an Array}
      it {result.length.should eq 3}
      it {result.last.success?.should be_true}
    end
    context "running a complex command" do
      let(:result){CmdRunner.run('ls','-l','-A','-F')}
      it {result.should be_an Array}
      it {result.length.should eq 3}
      it {result.last.success?.should be_true}
    end
    
    context "running a bogus command" do
      it {expect{CmdRunner.run("blahblahblah")}.to raise_error Errno::ENOENT}
    end


  end

end
