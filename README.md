[![Aypex::Checkout CI](https://github.com/aypex-io/aypex-checkout/actions/workflows/ci.yml/badge.svg)](https://github.com/aypex-io/aypex-checkout/actions/workflows/ci.yml)
[![Standard RB](https://github.com/aypex-io/aypex-checkout/actions/workflows/standardrb.yml/badge.svg)](https://github.com/aypex-io/aypex-checkout/actions/workflows/standardrb.yml)
[![Standard JS](https://github.com/aypex-io/aypex-checkout/actions/workflows/standardjs.yml/badge.svg)](https://github.com/aypex-io/aypex-checkout/actions/workflows/standardjs.yml)
[![StyleLint](https://github.com/aypex-io/aypex-checkout/actions/workflows/stylelint.yml/badge.svg)](https://github.com/aypex-io/aypex-checkout/actions/workflows/stylelint.yml)

# Aypex Checkout

A stand-alone checkout for Aypex

## Usage

Aypex Checkout can be used with the existing **Aypex StoreFront** and **Aypex Backend**, either one, or as a stand-alone Aypex Extension to be used with
any third-party storefront or admin UI.

Additionally, Aypex Checkout is both Propshaft and Sprockets ready.


## Installation

Add
```ruby
gem 'aypex-storefront', github: 'aypex-io/aypex-storefront'
gem 'aypex-checkout', github: 'aypex-io/aypex-checkout'
gem 'aypex-auth_devise', github: 'aypex-io/aypex-auth_devise'
```
to your `Gemfile`.

Run:

```bash
bundle install
bin/rails g aypex:checkout:install
```

## Checkout Flow

For the most part, the checkout flow is unchanged, your customer enters the checkout at `/checkout`
and upon completion the user is forwarded to `/orders/:order_number`, so this should be a drop-in replacement for
your existing checkout system.

When used with `aypex_auth_devise` your customer is sent to the registrations page as the first checkout step by default.
This can be changed so the customer is sent to the Address page as the first step be setting the following config:

```ruby
# config/initializers/aypex.rb

Aypex::Auth.configure do |config|
  config.registration_step = false
end
```

If you wish to have Aypex Checkout redirect your customer to a different exit point you can add the following to your Aypex initializer file.
```ruby
# config/initializers/aypex.rb

Aypex::Checkout.configure do |config|
  config.cart_route_name = :your_custom_cart_path_name
  config.orders_route_name = :your_custom_order_path_name
end
```

## Development

### Helper Methods
To ensure Aypex Checkout is a stand-alone Aypex extension please scope any helper methods with `aypex_checkout_`
don't worry about trying to be DRY any use existing helpers from any other lib, just make a name scoped copy here and
let that take the load, the only requirement for Aypex Checkout to run should be Aypex Core itself.

### JavaScript
All javascript is found within the `app/javascript` folder.

To work on the Javascript from the root of the `aypex_checkout` folder run `yarn install` and then `yarn watch`.

### CSS
All the CSS for Aypex Checkout is found within the `app/sass` folder, this is intentionally done
so that Propshaft or Sprockets can pick up ready to use CSS straight out of the assets folder without additional configuration.
This also provides a modern working environment for SCSS processing.

To work on the CSS from the root of the `aypex_checkout` folder run `yarn install` and then `yarn watch`.

## TODO

- [ ] Fix address management flow
- [ ] Fix Confirm Order Page
- [ ] Fix logout login flow.
- [ ] Write test suite for checkout flow
