class RenameRapnsToRpush < ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration
  module Rpush
    class App < ActiveRecord::Base
      self.table_name = 'rpush_apps'
    end

    class Notification < ActiveRecord::Base
      self.table_name = 'rpush_notifications'
    end
  end

  def self.update_type(model, from, to)
    model.where(type: from).update_all(type: to)
  end

  def self.up
    rename_table :rapns_notifications, :rpush_notifications
    rename_table :rapns_apps, :rpush_apps
    rename_table :rapns_feedback, :rpush_feedback

    if ActiveRecord.version >= Gem::Version.new('5.1')
      if index_name_exists?(:rpush_notifications, :index_rapns_notifications_multi)
        rename_index :rpush_notifications, :index_rapns_notifications_multi, :index_rpush_notifications_multi
      end
    else
      if index_name_exists?(:rpush_notifications, :index_rapns_notifications_multi, true)
        rename_index :rpush_notifications, :index_rapns_notifications_multi, :index_rpush_notifications_multi
      end
    end

    if ActiveRecord.version >= Gem::Version.new('5.1')
      if index_name_exists?(:rpush_feedback, :index_rapns_feedback_on_device_token)
        rename_index :rpush_feedback, :index_rapns_feedback_on_device_token, :index_rpush_feedback_on_device_token
      end
    else
      if index_name_exists?(:rpush_feedback, :index_rapns_feedback_on_device_token, true)
        rename_index :rpush_feedback, :index_rapns_feedback_on_device_token, :index_rpush_feedback_on_device_token
      end
    end

    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rapns::Apns::Notification', 'Rpush::Apns::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rapns::Gcm::Notification', 'Rpush::Gcm::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rapns::Adm::Notification', 'Rpush::Adm::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rapns::Wpns::Notification', 'Rpush::Wpns::Notification')

    update_type(RenameRapnsToRpush::Rpush::App, 'Rapns::Apns::App', 'Rpush::Apns::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rapns::Gcm::App', 'Rpush::Gcm::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rapns::Adm::App', 'Rpush::Adm::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rapns::Wpns::App', 'Rpush::Wpns::App')
  end

  def self.down
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rpush::Apns::Notification', 'Rapns::Apns::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rpush::Gcm::Notification', 'Rapns::Gcm::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rpush::Adm::Notification', 'Rapns::Adm::Notification')
    update_type(RenameRapnsToRpush::Rpush::Notification, 'Rpush::Wpns::Notification', 'Rapns::Wpns::Notification')

    update_type(RenameRapnsToRpush::Rpush::App, 'Rpush::Apns::App', 'Rapns::Apns::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rpush::Gcm::App', 'Rapns::Gcm::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rpush::Adm::App', 'Rapns::Adm::App')
    update_type(RenameRapnsToRpush::Rpush::App, 'Rpush::Wpns::App', 'Rapns::Wpns::App')

    if ActiveRecord.version >= Gem::Version.new('5.1')
      if index_name_exists?(:rpush_notifications, :index_rpush_notifications_multi)
        rename_index :rpush_notifications, :index_rpush_notifications_multi, :index_rapns_notifications_multi
      end
    else
      if index_name_exists?(:rpush_notifications, :index_rpush_notifications_multi, true)
        rename_index :rpush_notifications, :index_rpush_notifications_multi, :index_rapns_notifications_multi
      end
    end

    if ActiveRecord.version >= Gem::Version.new('5.1')
      if index_name_exists?(:rpush_feedback, :index_rpush_feedback_on_device_token)
        rename_index :rpush_feedback, :index_rpush_feedback_on_device_token, :index_rapns_feedback_on_device_token
      end
    else
      if index_name_exists?(:rpush_feedback, :index_rpush_feedback_on_device_token, true)
        rename_index :rpush_feedback, :index_rpush_feedback_on_device_token, :index_rapns_feedback_on_device_token
      end
    end

    rename_table :rpush_notifications, :rapns_notifications
    rename_table :rpush_apps, :rapns_apps
    rename_table :rpush_feedback, :rapns_feedback
  end
end
