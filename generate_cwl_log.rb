#
# generate_cwl_log.rb: assemble log data of a CWL workflow run
#

$LOAD_PATH << __dir__
$LOAD_PATH << File.join(__dir__, "lib")

require 'getoptlong'
require 'lib/cwllog'

if __FILE__ == $0
  opts = GetoptLong.new(
    ['--debug-output', GetoptLong::REQUIRED_ARGUMENT],
    ['--job-conf', GetoptLong::REQUIRED_ARGUMENT],
    ['--cidfile-dir', GetoptLong::REQUIRED_ARGUMENT],
    ['--docker-ps', GetoptLong::OPTIONAL_ARGUMENT],
    ['--docker-info', GetoptLong::OPTIONAL_ARGUMENT],
  )

  opts.each do |opt, arg|
    case opt
    when '--debug-output'
      CWLlog::CWL::DebugInfo.load(arg) # --debug output with timestamps
    when '--job-conf'
      CWLlog::CWL::JobConf.load(arg) # job conf yaml or json
    when '--cidfile-dir'
      CWLlog::CWL::DebugInfo.cidfile_dir(arg) # --debug output with timestamps
    when '--docker-ps'
      CWLlog::Docker.load_docker_ps(arg)
    when '--docker-info'
      CWLlog::Docker.load_docker_info(arg)
    end
  end

  puts CWLlog.generate
end
