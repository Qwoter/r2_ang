require 'rails_helper'

describe TablesController do
  render_views
  describe "index" do
    subject(:results) { JSON.parse(response.body) }

    def extract_number
      ->(object) { object["number"] }
    end

    context "when there are tables" do
      before do
        create(:table, number: '1')
        create(:table, number: '2')
        create(:table, number: '3')
        create(:table, number: '4')
        create(:table, number: '5')

        xhr :get, :index, format: :json
      end

      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return five results' do
        expect(results.size).to eq(5)
      end
      it "should include 'table #5'" do
        expect(results.map(&extract_number)).to include('5')
      end
      it "should include 'table #2'" do
        expect(results.map(&extract_number)).to include('2')
      end
    end

    context "when there are no tables" do
      before do
        Table.delete_all(1)

        xhr :get, :index, format: :json
      end

      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: table_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the table exists" do
      let(:table) { 
        create(:table) 
      }
      let(:table_id) { table.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(table.id) }
      it { expect(results["number"]).to eq(table.number) }
    end

    context "when the table doesn't exit" do
      let(:table_id) { -9999 }

      it { expect(response.status).to eq(404) }
    end
  end
  
  describe "create" do
    before do
      xhr :post, :create, format: :json, table: { number: "1" }
    end

    it { expect(response.status).to eq(201) }
    it { expect(Table.last.number).to eq("1") }
  end

  describe "update" do
    context "on successful update" do
      let(:table) { 
        create(:table, number: '1') 
      }

      before do
        xhr :put, :update, format: :json, id: table.id, table: { number: "1" }
        table.reload
      end

      it { expect(response.status).to eq(204) }
      it { expect(table.number).to eq("1") }
    end
  end

  describe "destroy" do
    let(:table_id) { 
      create(:table).id
    }

    before do
      xhr :delete, :destroy, format: :json, id: table_id
    end

    it { expect(response.status).to eq(204) }
    it { expect(Table.find_by_id(table_id)).to be_nil }
  end
end
