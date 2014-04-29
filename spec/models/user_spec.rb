require 'spec_helper'

describe User do

  it { should validate_presense_of(:username)}
  it { should validate_presense_of(:token)}
  it { should validate_uniqueness_of(:username)}
  it { should validate_uniqueness_of(:token)}

end

