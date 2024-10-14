require "sidekiq/testing"

RSpec.configure do |config|
  config.around do |example|
    # require 'pry'; binding.pry
    if example.metadata[:sidekiq_inline] == true
      Sidekiq::Testing.inline! { example.run }
    else
      example.run
    end
  end
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end
