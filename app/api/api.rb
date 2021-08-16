require 'grape-swagger'

class API < Grape::API
    prefix 'api'
    format :json
    mount V1::Books
    mount V1::Borrows

    add_swagger_documentation 
  end