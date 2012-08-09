module Audiofhile
  module Helpers
    def mute_stderr
      orig_stderr = STDERR.dup
      $stderr.reopen('/dev/null', 'w')
      yield
    ensure
      $stderr.reopen(orig_stderr)
    end
  end
end

