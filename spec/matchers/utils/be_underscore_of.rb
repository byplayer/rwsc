RSpec::Matchers.define :be_underscore_of do |expected|
  match do |actual|
    Rwsc::Utils::StringUtils::underscore(actual)  == expected
  end

  failure_message_for_should do |actual|
    "expected that #{actual} would be underscore of #{expected}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual} would not be a underscore of #{expected}"
  end

  description do
    "be a underscore of #{expected}"
  end
end

