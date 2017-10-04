# get_schwifty
>Oh, yeah!
You gotta get schwifty.
You gotta get schwifty in here.

get_schwifty is a Rails plugin for rendering slow view partials in a background job and sending them to the client over ActionCable websockets.

[![CI](https://travis-ci.org/danielwestendorf/get_schwifty.svg?branch=master)](https://travis-ci.org/danielwestendorf/get_schwifty) [![Gem Version](https://badge.fury.io/rb/get_schwifty.svg)](https://badge.fury.io/rb/get_schwifty)

## Justification

Slow-to-render HTML elements can be expensive (hosting) and unavoidable (technical debt, slow libs, expensive db queries, etc). Rendering in-line in your web server consumes a connection which could be serving other clients. Sometimes it's better to just return a minimal page quickly, and let the data backfill as it's generated.

get_schwifty is all about quick responses by utilizing background jobs to do the rendering for your and delivering it to the client with ActionCable.

## Caveats

- There is no gurantee that the content will load. If your background job queue get's backed up, you'll be not showing content anytime soon.

## Extracted from HireLoop

get_schwifty was extracted from [HireLoop.io](https://www.hireloop.io), a platform for a more human hiring experience.

Make hiring delightful by closing the loop between hiring managers and every applicant. Automate the trival tasks associated with screening job applicants, lowering the barrier for easy and clear communication.


## Installation
Add this line to your application's Gemfile:

```ruby
gem "get_schwifty"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install get_schwifty
```

Install the plugin
```bash
$ rails generate get_schwifty:install
```
Follow the instructions printed.


## Usage

Generate your first get_schwifty Cable
```bash
$ rails generate get_schwifty:cable Calculator fibonacci
```

Cables are a place to put your data access logic. Think Controllers for each get_schwifty cable.
```ruby
# app/cables/calculator_cable.rb

class CalculatorCable < BaseCable
  def fibonacci
    n = SecureRandom.rand(30..40)
    calculated = calculate_fibonacci(n)
    stream partial: "calculator/fibonacci", locals: { calculated: calculated, n: n }
  end

  private

  def calculate_fibonacci(n)
    return n if n <= 1
    calculate_fibonacci( n - 1 ) + calculate_fibonacci( n - 2 )
  end
end
```

When the data has been queried/generated, the partial is rendered. `stream` is a wrapper around the normal Rails `render`.

```erb
# app/views/cables/calculator/_fibonacci.html.erb
<p class="take-off-your-pants">
  Fibonacci of <%= n %> is <%= calculated %>
</p>

```

Lastly, we need to tell the app where to render this chunk of HTML. get_schwifty uses a similar routing syntax to Rails routes of `cablecontrollername#action`.

```erb
# app/views/yourpage.html.erb
... Other HTML ...
<%= get_schwifty "calculator#fibonacci" do %>
  <p>
    This will get displayed while the cable is waiting to get schwifty.
    Maybe markup for a loading animation?
  </p>
<%- end %>
... Other HTML ...
```

Load the page, and you should get the whole page back quickly, while the Fibonacci comes later.

### Identifiers & Params

Random data isn't very useful. Unauthenticated data isn't very cool either. Usually in Rails data scoping belongs starts at a current_user method. get_schwifty will make any identefiers or params made available in the channel subscription within your cables. Let's take a look at an example.

#### Identifiers
Here we'll find the current user. This is copied form the [Rails Guides](http://guides.rubyonrails.org/action_cable_overview.html#connection-setup).
``` ruby
# app/channels/connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if current_user = User.find_by(id: cookies.signed[:user_id])
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
```

Let's assume the `User#fibonacci` returns and integer to use in the `CalculatorCable#fibonacci`.
```ruby
# app/cables/calculator_cable.rb

class CalculatorCable < BaseCable
  def fibonacci
    n = identifiers[:current_user]
    ... same code as before ..
  end
end
```

Similarly, any other identifiers created in the connection will follow suite and be made available in your cable. Additionally, you may want to add getter methods to `BaseCable` make accessing identifiers easier.

#### Params

Code reusability is the Rails way, so maybe we need to tweak how the cable's action is invoked dynamically, based on where the HTML is to be rendered. This is easy as pie, simply pass a hash of parameters to the `get_schwifty` view helper.

```erb
# app/views/yourpage.html.erb
... Other HTML ...
<%= get_schwifty "calculator#fibonacci", min_start: 3 do %>
  ... same as before ...
<%- end %>
... Other HTML ...
```

These params will be available in your cable action.
```ruby
# app/cables/calculator_cable.rb

class CalculatorCable < BaseCable
  def fibonacci
    n = SecureRandom.rand(params[:min_start]..40)
    ... same code as before ..
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
