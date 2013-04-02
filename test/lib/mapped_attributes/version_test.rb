require_relative '../../test_helper'

describe MappedAttributes do

  it "version must be defined" do
    MappedAttributes::VERSION.wont_be_nil
  end

end