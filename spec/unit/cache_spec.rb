require 'spec_helper'

describe Factual::Cache do
  include TestHelpers

  before(:each) do
    Factual::Cache.config do
      get do |url|

      end
      set do |url, response|

      end
    end
  end

  it "should run" do
    
  end
end
