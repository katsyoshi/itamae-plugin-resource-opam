require "spec_helper"

describe file("/root/.opam/4.06.0/bin/coqc") do
  it { should be_file }
  it { should be_executable }
end
