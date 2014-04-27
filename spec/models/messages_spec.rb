require 'spec_helper'

describe Message do

  it { should belong_to(:user)}
  it { should belong_to(:chatroom)}

end