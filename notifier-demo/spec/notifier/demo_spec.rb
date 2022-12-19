# frozen_string_literal: true

RSpec.describe Notifier::Demo do
  it "has a version number" do
    expect(Notifier::Demo::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
