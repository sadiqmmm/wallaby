require 'rails_helper'

partial_name = 'show/datetime'
describe partial_name do
  let(:partial)   { "wallaby/resources/#{partial_name}.html.erb" }
  let(:value)     { Time.new(2014, 2, 11, 23, 59, 59, '+00:00') }
  let(:metadata)  { {} }

  before { render partial, value: value, metadata: metadata }

  it 'renders the datetime' do
    expect(rendered).to eq "  Tue, 11 Feb 2014 23:59:59 +0000\n"
  end

  context 'when value is a string' do
    let(:value) { 'Tue, 11 Feb 2014 23:59:59 +0000' }

    it 'renders the datetime' do
      expect(rendered).to eq "  Tue, 11 Feb 2014 23:59:59 +0000\n"
    end
  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'renders null' do
      expect(rendered).to eq "  <i class=\"text-muted\">&lt;null&gt;</i>\n"
    end
  end
end
