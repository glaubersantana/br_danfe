require "spec_helper"

describe BrDanfe::Cep do
  describe ".format" do
    it "returns a formated CEP" do
      cep = "12345678"
      expect(BrDanfe::Cep.format(cep)).to eq "12.345-678"
    end
  end
end
