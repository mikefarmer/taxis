require 'spec_helper'
require 'ap'

describe Taxon, "associations" do
  before(:each) do
    @product = Product.create(:name => "product1")
    @product2 = Product.create(:name => "product2")
    @page = Page.create(:name => "page1")
    @taxon = Taxon.create(:name => "taxon_test")

    @taxon.attach @product
    @taxon.attach @page
  end

  describe "accessing taxon attached classes" do
    
    it "should allow access to pages through attach_* " do
      @taxon.attached_pages.should include @page
    end

    it "should allow access to products through attach_* " do
      @taxon.attached_products.should include @product
    end

    it "should throw an error if I try to access products directly " do
      lambda { @taxon.products }.should raise_error
    end

    it "should not respond to a non-activerecord class" do
      class ::Breadcrumb; end
      lambda { @taxon.attached_breadcrumbs }.should raise_error
    end

  end

  describe "attaching and detaching" do
    

    it "should have a correct taxonable_type" do
      product_ti = TaxonItem.first
      page_ti = TaxonItem.last
      product_ti.taxonable_type.should == "Product"
      page_ti.taxonable_type.should == 'Page'
    end


    it "should detach a record" do
      @taxon.attach(@product2)
      @taxon.detach(@product2)
      @taxon.attached_products.should_not include @product2
    end

    it "should allow attaching to child taxons" do
      @taxon.children.create(Taxon.new(:name => "child1"))
      child = @taxon.children.last
      child.attach(@product)
      child.attached_products.should include @product
    end

    describe "when attaching or detaching by param" do
      it "should attach" do
        p = Product.create(:name => "test")
        @taxon.attach_by_param('Product', p.id)
        @taxon.attached_products.last.should == p
      end

      it "should detach" do
        p = @taxon.attached_products.last
        @taxon.detach_by_param('Product', p.id)
        @taxon.attached_products.should_not include p
      end

      it "should not allow invalid params" do
        lambda { @taxon.attach_by_param 'Invalid Class Name', 1 }.should raise_error
        lambda { @taxon.attach_by_param 'Product', 1000 }.should raise_error
        lambda { @taxon.detach_by_param 'Invalid Class Name', 1 }.should raise_error
        lambda { @taxon.detach_by_param 'Product', 1000 }.should raise_error
      end

      
    end

    describe "when multiple types are attached to a single taxon" do

      before :each do
        @child = @taxon.children.create(:name => "test")
        @child.attach @product
        @child.attach @page
      end

      subject{ @child }

      its(:attached_pages) { should include @page }
      its(:attached_pages) { should_not include @product }

      its(:attached_products) { should include @product }
      its(:attached_products) { should_not include @page }

    end


  end



end

