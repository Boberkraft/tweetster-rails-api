require 'rails_helper'


RSpec.describe Tweet do
  context 'Stary sypiacy sie test' do
    it { expect("beka").to eq("beka") }
  end
  
  
   context 'nowe sypiacy sie test' do
    it { expect("dasdasd").to eq("beka") }
  end
  
  context 'nowe nie sypiacy sie test' do
    it { expect(33).to eq(33) }
  end
end
