require 'spec_helper'
require 'collection'

module TunesTools
  describe Collection do
    its("directory.path") { should_not be_empty }
  end
end
