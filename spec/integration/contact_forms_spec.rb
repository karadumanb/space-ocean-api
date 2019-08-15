# spec/integration/contact_forms_spec.rb
require 'swagger_helper'

describe 'Contact Forms API' do

  path '/contact_forms' do

    post 'Sends email to us' do
      tags 'Contact Forms'
      consumes 'application/json'
      parameter name: :contact_form, in: :body, schema: {
        '$ref' => '#/definitions/contact_form'
      }

      response '201', 'contact_form created' do
        let(:contact_form) { { title: 'Baturay', description: 'creator of this api, rails magician/creator of this api, rails magician' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:contact_form) { { title: 'foo' } }
        run_test!
      end
    end
  end
end
