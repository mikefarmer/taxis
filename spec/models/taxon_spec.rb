require 'spec_helper'
require 'ap'

describe Taxon, "associations" do
  before(:each) do
    @product = Product.create(:name => "product1")
    @product2 = Product.create(:name => "product2")
    @page = Page.create(:name => "page1")
    @taxon = Taxon.create(:name => "taxon_test")
    2.times do |x|
      @taxon.children.create(Taxon.new(:name => "kiddo #{x}"))
    end

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

  end

  describe "attaching and detatching" do
    

    it "should have a correct taxonable_type" do
      product_ti = TaxonItem.first
      page_ti = TaxonItem.last
      product_ti.taxonable_type.should == "Product"
      page_ti.taxonable_type.should == 'Page'
    end


    it "should detatch a record" do
      @taxon.attach(@product2)
      @taxon.detatch(@product2)
      @taxon.attached_products.should_not include @product2
    end

    it "should allow attaching to child taxons" do
      child = @taxon.children.last
      child.attach(@product)
      child.attached_products.should include @product
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

