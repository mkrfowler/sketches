require 'rails_helper'

RSpec.describe SamplesController, type: :controller do
  it 'works' do
    get :index, a: 1, b: 2, c: 3
    get :index, a: 1
    get :index, params: { a: 1, b: 2, c: 3 }
  end
end
