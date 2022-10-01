# frozen_string_literal: true

module Api
  module V1
    module Json
      def api_json(obj, user, opts = {}, _permissions_to_return = [])
        obj.as_json({ include_root: false,
                      except: %w[id],
                      user: user }.merge(opts))
      end
    end
  end
end
