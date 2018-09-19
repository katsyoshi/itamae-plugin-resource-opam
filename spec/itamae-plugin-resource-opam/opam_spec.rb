require "spec_helper"

describe file("/root/.opam/4.05.0/bin/coqc") do
  it { should be_directory }
end
