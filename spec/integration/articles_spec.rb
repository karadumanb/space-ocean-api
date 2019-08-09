# spec/integration/articles_spec.rb
require 'swagger_helper'

describe 'Articles API' do

  path '/articles' do

    post 'Creates a article' do
      tags 'Articles'
      consumes 'application/json', 'application/xml'
      parameter name: :article, in: :body, schema: {
        '$ref' => '#/definitions/create_article'
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

  path '/articles/{id}' do

    get 'Retrieves an article' do
      tags 'Articles'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'title found' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                required: %i[id type attributes],
                properties: {
                  id: { type: :string },
                  type: { type: :string },
                  attributes: {'$ref' => '#/definitions/article'}
                }
              }
            }
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
