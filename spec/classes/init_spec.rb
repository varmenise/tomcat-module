require 'spec_helper'

describe 'tomcat7' do
 it 'test java 7 installed' do
   should contain_package ('openjdk-7-jdk')
 end
 it 'test wget is installed' do 
  should contain_package ('wget')
 end
 it 'tests tomcat' do 
 should contain_service('tomcat7').with(
 'ensure' => 'running'
) 
end
end

