require 'spec_helper_acceptance'

describe 'tomcat7 class:', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should run successfully' do
    pp = "class { 'tomcat7': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, :catch_failures => true) do |r|
      expect(r.stderr).not_to match(/error/i)
    end
  end
end