# spec/integration/articles_spec.rb
require 'swagger_helper'

describe 'Articles API' do

  path '/api/articles' do

    post 'Creates a article' do
      tags 'Articles'
      consumes 'application/json', 'application/xml'
      parameter name: :article, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          user_id: { type: :integer },
          user_name: { type: :string }
        },
        required: [ 'title', 'description' ]
      }

      response '201', 'article created' do
        let(:article) { { title: 'Baturay', description: 'creator of this api, rails magician/creator of this api, rails magician' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:article) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/articles/{id}' do

    get 'Retrieves a article' do
      tags 'Articles'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'title found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string }
          },
          required: [ 'id', 'title', 'description' ]

        let(:id) { Article.create(title: 'foo', description: 'bar bar foobarbar bar foobarbar bar foobarbar bar foobar').id }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
