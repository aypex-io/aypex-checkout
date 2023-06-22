Aypex::Engine.routes.draw do
  scope "(:locale)", locale: /#{Aypex.available_locales.join('|')}/, defaults: {locale: nil} do
    namespace :checkout do
      namespace :users do
        get :login
      end
      resources :addresses do
        collection do
          get :address_manager
        end
      end

      root to: "orders#edit"
      get "/:state", to: "orders#edit", as: :state
      get "/pages/:slug", to: "pages#show", as: :pages

      patch "update/:state", to: "orders#update"
      patch "apply_coupon", to: "orders#apply_coupon", as: :apply_coupon
      patch "remove_coupon/:code", to: "orders#remove_coupon", as: :remove_coupon
      patch "update_shipping_choice", to: "orders#update_shipping_choice"

      post "change_address_country", to: "orders#change_address_country"

      get :forbidden, to: "errors#forbidden", as: :forbidden
      get :unauthorized, to: "errors#unauthorized", as: :unauthorized
    end
  end
end
