require 'rails_helper'

describe Wallaby::LinksHelper, :current_user do
  extend Wallaby::ApplicationHelper

  describe '#index_path' do
    it 'returns index path' do
      expect(helper.index_path Product).to match '/products'
    end
  end

  describe '#new_path' do
    it 'returns new path' do
      expect(helper.new_path Product).to match '/products/new'
    end
  end

  describe '#show_path' do
    it 'returns show path' do
      expect(helper.show_path Product.new id: 1).to match '/products/1'
    end
  end

  describe '#edit_path' do
    it 'returns edit path' do
      expect(helper.edit_path Product.new id: 1).to match '/products/1/edit'
    end
  end

  describe '#index_link' do
    it 'returns index link' do
      expect(helper.index_link(Product)).to eq "<a href=\"/admin/products\">Product</a>"
      expect(helper.index_link(Product) { 'List' }).to eq "<a href=\"/admin/products\">List</a>"
    end

    context 'when cannot index' do
      it 'returns nil' do
        expect(helper).to receive(:cannot?) { true }
        expect(helper.index_link Product).to be_nil
      end
    end
  end

  describe '#new_link' do
    it 'returns new link' do
      expect(helper.new_link Product).to eq "<a class=\"text-success\" href=\"/admin/products/new\">Create Product</a>"
      expect(helper.new_link(Product) { 'New' }).to eq "<a class=\"text-success\" href=\"/admin/products/new\">New</a>"
      expect(helper.new_link(Product, class: 'test')).to eq "<a class=\"test\" href=\"/admin/products/new\">Create Product</a>"
    end

    context 'when cannot new' do
      it 'returns nil' do
        expect(helper).to receive(:cannot?) { true }
        expect(helper.new_link Product).to be_nil
      end
    end
  end

  describe '#show_link' do
    let(:resource) { Product.new id: 1 }

    it 'returns show link' do
      expect(helper.show_link(resource)).to eq "<a href=\"/admin/products/1\">1</a>"
      expect(helper.show_link(resource) { 'Show' }).to eq "<a href=\"/admin/products/1\">Show</a>"
    end

    context 'when cannot show' do
      it 'returns nil' do
        expect(helper).to receive(:cannot?) { true }
        expect(helper.show_link resource ).to be_nil
      end
    end
  end

  describe '#edit_link' do
    let(:resource) { Product.new id: 1 }

    it 'returns edit link' do
      expect(helper.edit_link(resource)).to eq "<a class=\"text-warning\" href=\"/admin/products/1/edit\">Edit 1</a>"
      expect(helper.edit_link(resource) { 'Edit' }).to eq "<a class=\"text-warning\" href=\"/admin/products/1/edit\">Edit</a>"
      expect(helper.edit_link(resource, class: 'test')).to eq "<a class=\"test\" href=\"/admin/products/1/edit\">Edit 1</a>"
    end

    context 'when cannot edit' do
      it 'returns nil' do
        expect(helper).to receive(:cannot?) { true }
        expect(helper.edit_link resource ).to be_nil
      end
    end
  end

  describe '#delete_link' do
    let(:resource) { Product.new id: 1 }

    it 'returns delete link' do
      expect(helper.delete_link(resource)).to eq "<a class=\"text-danger\" data-confirm=\"Please confirm to delete\" rel=\"nofollow\" data-method=\"delete\" href=\"/admin/products/1\">Delete</a>"
      expect(helper.delete_link(resource) { 'Destroy' }).to eq "<a class=\"text-danger\" data-confirm=\"Please confirm to delete\" rel=\"nofollow\" data-method=\"delete\" href=\"/admin/products/1\">Destroy</a>"
      expect(helper.delete_link(resource, class: 'test')).to eq "<a class=\"test\" data-confirm=\"Please confirm to delete\" rel=\"nofollow\" data-method=\"delete\" href=\"/admin/products/1\">Delete</a>"
      expect(helper.delete_link(resource, method: :put)).to eq "<a class=\"text-danger\" data-confirm=\"Please confirm to delete\" rel=\"nofollow\" data-method=\"put\" href=\"/admin/products/1\">Delete</a>"
      expect(helper.delete_link(resource, data: { confirm: 'Delete now!' })).to eq "<a data-confirm=\"Delete now!\" class=\"text-danger\" rel=\"nofollow\" data-method=\"delete\" href=\"/admin/products/1\">Delete</a>"
    end

    context 'when cannot delete' do
      it 'returns nil' do
        expect(helper).to receive(:cannot?) { true }
        expect(helper.delete_link resource ).to be_nil
      end
    end
  end

  describe '#cancel_link' do
    it 'returns cancel link' do
      expect(helper.cancel_link).to eq "<a href=\"javascript:history.back()\">Cancel</a>"
      expect(helper.cancel_link { 'Back' }).to eq "<a href=\"javascript:history.back()\">Back</a>"
    end
  end

  describe '#prepend_if' do
    it 'returns the prepended text' do
      expect(helper.prepend_if).to be_nil
      expect(helper).to receive(:concat).with('Or ') { 'Or ' }

      html_options = { prepend: 'Or' }
      expect(helper.prepend_if html_options).to eq 'Or '
      expect(html_options).not_to have_key :prepend
    end
  end
end  
