module V1
  class UserResource < BaseResource

    class << self
      def createable_fields(context)
        [:name,:mobile_phone_number,:email_address,:physical_address]
      end

      alias_method :updatable_fields, :createable_fields

    end

    def fetchable_fields
      super + self.class.createable_fields(context) + [:created_at, :updated_at]
    end
  end
end
