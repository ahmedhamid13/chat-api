# frozen_string_literal: true

require 'pagy/extras/overflow'
require 'pagy/extras/array'

# default :empty_page (other options :last_page and :exception )
Pagy::DEFAULT[:overflow] = :empty_page

# OR
# require 'pagy/countless'
# require 'pagy/extras/overflow'

# # default :empty_page (other option :exception )
# Pagy::DEFAULT[:overflow] = :exception

Pagy::DEFAULT[:page]   = 1                                  # default
Pagy::DEFAULT[:items]  = 12                                 # default
Pagy::DEFAULT[:outset] = 0                                  # default

Pagy::DEFAULT[:size]       = [1, 4, 4, 1] # default
Pagy::DEFAULT[:page_param] = :page # default
# The :params can be also set as a lambda e.g ->(params){ params.exclude('useless').merge!('custom' => 'useful') }
Pagy::DEFAULT[:params]     = {}                              # default
Pagy::DEFAULT[:fragment]   = '#fragment'                     # example
Pagy::DEFAULT[:link_extra] = 'data-remote="true"'            # example
Pagy::DEFAULT[:i18n_key]   = 'pagy.item_name'                # default
Pagy::DEFAULT[:cycle]      = true                            # example

Pagy::DEFAULT.freeze
