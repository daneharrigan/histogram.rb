module Histogram
  module Framework
    module Rails
      class ActionControllerSubscriber < ActiveSupport::LogSubscriber
        def process_action(e)
          Histogram::DB.record(e.transaction_id).controller = e
          Histogram::DB.compress(e.transaction_id)
        end
      end

      class ActionViewSubscriber < ActiveSupport::LogSubscriber
        def render_template(e)
          record = Histogram::DB.record(e.transaction_id)
          record.views << e
          record.layout = e.payload[:layout]
        end

        def render_partial(e); end
        def render_collection(e); end
      end

      class ActiveRecordSubscriber < ActiveSupport::LogSubscriber
        IGNORE_PAYLOAD_NAMES = ["SCHEMA", "EXPLAIN"]

        def sql(e)
          return if IGNORE_PAYLOAD_NAMES.include? e.payload[:name]
          name = e.payload[:name]
          return if name && name.include?("SchemaMigration")
          Histogram::DB.record(e.transaction_id).models << e
        end
      end
    end
  end
end

Histogram::Framework::Rails::ActionControllerSubscriber.attach_to :action_controller
Histogram::Framework::Rails::ActionViewSubscriber.attach_to :action_view
Histogram::Framework::Rails::ActiveRecordSubscriber.attach_to :active_record
#Histogram::Framework::Rails::ActionMailerSubscriber.attach_to :action_mailer
