# frozen_string_literal: true

RSpec.describe 'DiscourseBlankPages engine routing', type: :routing do
  routes { ::DiscourseBlankPages::Engine.routes }

  it 'engine route maps to controller method' do
    expect(get: '/some_page_id').to route_to(
      controller: 'discourse_blank_pages/blank_page',
      action: 'show',
      page_id: 'some_page_id'
    )
  end
end

RSpec.describe 'Simulate requests to the mounted engine routes', type: :request do

  describe 'GET discourse_blank_pages/blank_page#show' do
    ENGINE_MOUNT_PATH = '/pages'
    BASIC_TEST_ROUTE = 'test_route'
    NESTED_TEST_ROUTE = 'nested/route'

    before do
      SiteSetting.valid_routes = [BASIC_TEST_ROUTE, NESTED_TEST_ROUTE].join('|')
    end

    it 'returns success on basic recognized route' do
      get "#{ENGINE_MOUNT_PATH}/#{BASIC_TEST_ROUTE}"
      expect(response).to have_http_status(:success)
    end

    it 'returns success on nested recognized route' do
      get "#{ENGINE_MOUNT_PATH}/#{NESTED_TEST_ROUTE}"
      expect(response).to have_http_status(:success)
    end

    it 'returns 302 redirect to /404 on invalid route' do
      get "#{ENGINE_MOUNT_PATH}/invalid"
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to('/404')
    end
  end

end
