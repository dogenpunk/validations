require 'i18n'
require 'dry/validation/messages/i18n'

I18n.load_path = Dir['test/fixtures/i18n/*.yml']
I18n.backend.load_translations

module SharedPredicates
  include Hanami::Validations::Predicates

  self.messages = :i18n

  predicate :accepted? do |actual|
    actual && actual == true
  end
end

class SignupValidator
  include Hanami::Validations
  messages_path 'test/fixtures/messages.yml'

  validations do
    required(:age).filled(:int?, gt?: 18)
  end
end

module Web
  module Controllers
    module Signup
      class Create
        class Params
          include Hanami::Validations::Form
          messages_path 'test/fixtures/messages.yml'

          validations do
            required(:age).filled(:int?, gt?: 18)
          end
        end
      end
    end
  end
end

class DomainValidator
  include Hanami::Validations
  messages :i18n

  validations do
    required(:name).filled(:str?, max_size?: 253)
  end
end

# FIXME: https://github.com/dry-rb/dry-validation/issues/183
# class ChangedTermsOfServicesValidator
#   include Hanami::Validations::Form
#   predicates SharedPredicates

#   validations do
#     required(:terms).filled(:bool?, :accepted?)
#   end
# end