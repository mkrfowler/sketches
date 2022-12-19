# frozen_string_literal: true
require 'active_support'

module Notifier
  module Demo
    VERSION = "0.1.0"

    def self.enable!
      @subscriber ||= ActiveSupport::Notifications.subscribe(/demo\.notifier/) do |*payload|
        $stderr.puts "payload: #{payload}"
      end
    end

    def self.disable!
      if @subscriber
        ActiveSupport::Notifications.unsubscribe(@subscriber)
        @subscriber = nil
      end
    end

    def self.split(name:, use:, try:)
      ActiveSupport::Notifications.instrument('demo.notifier', test_name: name) do |payload|
        use_res = ActiveSupport::Notifications.instrument('demo.notifier.use') { use.call }
        try_res = ActiveSupport::Notifications.instrument('demo.notifier.use') { try.call }

        payload[:mismatch] = use_res != try_res

        use_res
      end
    end
  end
end
