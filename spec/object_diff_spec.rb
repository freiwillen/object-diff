require "spec_helper"
require 'ostruct'

RSpec.describe ObjectDiff do
  it "has a version number" do
    expect(ObjectDiff::VERSION).not_to be nil
  end
end

