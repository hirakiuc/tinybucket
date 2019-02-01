require 'spec_helper.rb'

RSpec.describe Tinybucket::Encoder::ApiParamsEncoder do

  subject { Tinybucket::Encoder::ApiParamsEncoder }
  let(:input) { { a: 'first', b: 'middle', z: 'last', q: { query: 'value' } } }


  describe '.encode' do
    it "should define the .encode method" do
      expect(subject).to respond_to(:encode)
    end

    it "should return '' if params is empty" do
      expect(subject.encode({})).to eq('')
    end

    it "should return a String value" do
      expect(subject.encode({})).to be_a(String)
    end

    it "should return nil if params is nil" do
      expect(subject.encode(nil)).to be_nil
    end

    it "should sort the parameters on the output" do
      unsorted_input = { z: 'last', a: 'first' }
      sorted_regex = /^.*&?a=.*&z=.*$/
      expect(subject.encode(unsorted_input)).to match(sorted_regex)
    end

    it "should include the same number of conditions on the url than parameters" do 
      expect(subject.encode(input).split('&').count).to eq(input.count)
    end

    describe "when query parameters" do
  
      it "should interpret properly the multilevel objects parameters" do
        input = { q: {a: { b: 'c' }}}
        expect(subject.encode(input)).to include("q=a.b=%22c%22")
      end
      
      it "should interpret properly the string parameters" do
        input = { q: {a: 'Text' }}
        expect(subject.encode(input)).to include("q=a=%22Text%22")
      end
  
      it "should interpret properly the boolean parameters" do
        input = { q: {a: true }}
        expect(subject.encode(input)).to include("q=a=true")
      end
  
      it "should interpret properly the numeric parameters" do
        input = { q: { a: 1 }}
        expect(subject.encode(input)).to include("q=a=1")
      end
  
      it "should interpret properly the date_time parameters" do
        now = Time.now
        input = { q: {a: now }}
        regex = /.*#{now.year}.*#{now.month}.*#{now.day}.*#{now.hour}.*#{now.min}.*#{now.sec}.*/
        expect(subject.encode(input)).to match(regex)
      end
      
      it "should interpret properly the nil parameters" do
        input = { q: {a: nil }}
        expect(subject.encode(input)).to include("a=null")
      end
  
      it "should separate parameters on the output using the '&' character" do
        response = subject.encode(input)
        expect(response).to include('&')
        expect(response.split('&').count).to eq(input.count)
      end
      
      it "should start the output with a 'q=' concatenation" do
        input = { q: {a: 'value' } }
        expect(subject.encode(input)).to start_with('q=')
      end
    end

    
  end

  describe '.decode' do 
    it "should define the .decode method" do
      expect(subject).to respond_to(:decode)
    end

    it "should return nil if the encoded params are nil" do
      expect(subject.decode(nil)).to be_nil
    end

    describe 'when query parameters' do 
      it "should interpret properly the abscense of value" do
        query = "q=a"
        expect(subject.decode(query)).to eq({q: {a: true}})
      end

      it "should interpret properly the multilevel objects encoded parameters" do
        query = "q=a.b=\"c\""
        expect(subject.decode(query)).to eq({q: {a: {b: 'c'}}})
      end
      
      it "should interpret properly the string encoded parameters" do
        query = "q=a=\"Text\""
        expect(subject.decode(query)).to eq({q: {a: 'Text'}})
      end
  
      it "should interpret properly the boolean encoded parameters" do
        query = "q=a=true"
        expect(subject.decode(query)).to eq({q: {a: true}})
      end
  
      it "should interpret properly the numeric encoded parameters" do
        query = "q=a=1"
        expect(subject.decode(query)).to eq({q: {a: 1}})
      end
  
      it "should interpret properly the date_time encoded parameters" do
        now = Time.now
        query = "q=a=#{now.to_s}"
        expect(subject.decode(query)[:q][:a].to_i).to eq(now.to_i)
      end
      
      it "should interpret properly the nil encoded parameters" do
        query = "q=a=null"
        expect(subject.decode(query)).to eq({q: {a: nil}})
      end

    end

    
  end

end