title 'docker image'

control 'inspec version' do
  impact 1.0
  title 'confirm inspec version'
  desc 'Confirm correct version of inspec'
  describe command('inspec -v') do
    its('stdout') { should include ('4.18.39') }
    its('exit_status') { should eq 0 }
  end
end

control 'docker version' do
  impact 1.0
  title 'confirm docker version'
  desc 'Confirm correct version of docker'
  describe command('docker -v') do
    its('stdout') { should include ('Docker version') }
    its('exit_status') { should eq 0 }
  end
end

control 'docker-compose version' do
  impact 1.0
  title 'confirm docker-compose version'
  desc 'Confirm correct version of docker-compose'
  describe command('docker-compose -v') do
    its('stdout') { should include ('docker-compose version') }
    its('exit_status') { should eq 0 }
  end
end

control 'make version' do
  impact 1.0
  title 'confirm make version'
  desc 'Confirm correct version of make'
  describe command('make -v') do
    its('stdout') { should include ('GNU Make') }
    its('exit_status') { should eq 0 }
  end
end
