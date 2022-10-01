# frozen_string_literal: true

module Api::V1::Json
  def api_json(obj, user, opts = {}, _permissions_to_return = [])
    obj.as_json({ include_root: false,
                  except: %w[id],
                  user: user }.merge(opts))
  end
end