control 't3base-physical-1' do
  title 'Automatically detect data center and apply attributes'
  desc '
    This suite sets the virtualization/masterserver attribute to test.vagrant
    so that we seem to be in the "test" data center.
    Now check that the attributes defined for this DC are set.
  '
  describe service('ntpd') do
    it { should be_running }
  end

  describe package('lvm') do
    it { should be_installed }
  end
end