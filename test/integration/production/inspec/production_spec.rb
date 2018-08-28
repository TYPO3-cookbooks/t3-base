control 't3base-production-1' do
  title 'Automatically detect data center and apply attributes'
  desc '
    This suite sets the virtualization/masterserver attribute to test.vagrant
    so that we seem to be in the "test" data center.
    Now check that the attributes defined for this DC are set.
  '
  describe file('/etc/aliases') do
    its('content') { should match /johnsysadmin:\s+john@example.org/}
  end
end

control 't3base-production-2' do
  title 'Etckeeper configuration'
  desc 'Verifies etckeeper configuration'

  # we don't want daily autocommit
  describe file('/etc/etckeeper/etckeeper.conf') do
    it { should exist }
    its('content') { should match %r{^AVOID_DAILY_AUTOCOMMITS=1$} }
  end

  describe parse_config_file('/etc/postfix/main.cf') do
    its('relayhost') { should include 'mailrelay.invalid'}
  end
end
