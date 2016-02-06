control 't3base-production-1' do
  title 'Automatically detect data center and apply attributes'
  desc '
    This suite sets the virtualization/masterserver attribute to test.vagrant
    so that we seem to be in the "test" data center.
    Now check that the attributes defined for this DC are set.
  '
  describe file('/etc/postfix/main.cf') do
    its('content') { should match /relayhost = test.example.com/ }
  end

  describe file('/etc/aliases') do
    its('content') { should match /johnsysadmin:\s+"john@example.org"/}
  end
end