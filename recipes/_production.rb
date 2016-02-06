node.set[:postfix][:aliases][:root] = %w{
  michael.stucki@typo3.org
  peter.niederlag@typo3.org
  steffen.gebert@typo3.org
  bastian.bringenberg@typo3.org
  fabien.udriot@typo3.org
}
node.set[:postfix][:aliases][:bbringenberg] = 'bastian.bringenberg@typo3.org'
node.set[:postfix][:aliases][:mstucki]      = 'michael.stucki@typo3.org'
node.set[:postfix][:aliases][:sgebert]      = 'steffen.gebert@typo3.org'
node.set[:postfix][:aliases][:pniederlag]   = 'peter.niederlag@typo3.org'
node.set[:postfix][:aliases][:fudriot]      = 'fabien.udriot@typo3.org'

%w{
  t3-chef-client
  t3-chef-client::knife-lastrun
  etckeeper::commit
  t3-zabbix::agent
  backuppc
}.each do |recipe|
  include_recipe recipe
end
