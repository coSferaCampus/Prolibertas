module BSON
  class ObjectId
    def to_json(*args)
      to_s.to_json(args)
    end

    def as_json(*args)
      to_s.as_json(args)
    end
  end
end