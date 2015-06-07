require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the page title" do
      full_title("XXX").should =~ /XXX/
    end

    it "should include the base title" do
      full_title("XXX").should =~ /^Abi Singing/
    end

    it "should not include a bar for the home page" do
      full_title("").should_not =~ /\|/
    end
  end
end