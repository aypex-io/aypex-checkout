class AddAypexCheckoutSettingsToAypexStores < ActiveRecord::Migration[7.0]
  def change
    change_table :aypex_stores do |t|
      if t.respond_to? :jsonb
        add_column :aypex_stores, :aypex_checkout_settings, :jsonb
      else
        add_column :aypex_stores, :aypex_checkout_settings, :json
      end
    end
  end
end
