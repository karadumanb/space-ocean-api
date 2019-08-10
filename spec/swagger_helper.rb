require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.to_s + '/swagger'

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:to_swagger' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API SpaceOcean',
        version: 'SpaceOcean',
        description: 'This is API SpaceOcean version. It is used for SpaceOcean react application. Request urls => dev: http://localhost:3000, production: https://SpaceOcean.io'
      },
      basePath: '/api',
      paths: {},
      definitions: {
        article: {
          type: :object,
          required: %i[id user_id user_name description title],
          properties: {
              id: { type: :integer, example: 4102},
              user_id: { type: :string, example: 215},
              user_name: { type: :string, example: 'SpaceOcean'},
              description: { type: :string, example: 'SpaceOcean Article Example, This description should include minimum 10 and max 800 characters'},
              title: { type: :string, example: 'SpaceOcean Title'},
              image_url: { type: :string, 'x-nullable': true, example: '/rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBIQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8612cd3a32da9935f2ebeae54a39a2b8a9c42626/Screenshot%202019-08-07%20at%2012.50.30.png'}
          }
        },
        create_article: {
          type: :object,
          required: %i[description title],
          properties: {
            description: { type: :string, example: 'SpaceOcean Article Example, This description should include minimum 10 and max 800 characters'},
            title: { type: :string, example: 'SpaceOcean Title'}
          }
        }
      }
    }
  }
end
