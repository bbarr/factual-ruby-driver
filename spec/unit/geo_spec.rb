require 'spec_helper'

describe Factual::Query::Geocode do
  include TestHelpers

  LAT = 34.06021
  LNG = -118.41828

  before(:each) do
    @token = get_token
    @api = get_api(@token)
    @base = "http://api.v3.factual.com/places"

    @geocode = Factual::Query::Geocode.new(@api, LAT, LNG)
    @geopulse = Factual::Query::Geopulse.new(@api, LAT, LNG)
  end

  it "should be able to set the geocode url" do
    @geocode.first
    expected_url = @base + %{/geocode?geo={"$point":[#{LAT},#{LNG}]}}
    CGI::unescape(@token.last_url).should == expected_url
  end

  it "should be able to set the geopulse url" do
    @geopulse.first
    expected_url = @base + %{/geopulse?geo={"$point":[#{LAT},#{LNG}]}}
    CGI::unescape(@token.last_url).should == expected_url
  end

  it "should be able to set select of geopulse" do
    @geopulse.select(:income, :race).first
    expected_url = @base + %{/geopulse?geo={"$point":[#{LAT},#{LNG}]}&select=income,race}
    CGI::unescape(@token.last_url).should == expected_url
  end
end