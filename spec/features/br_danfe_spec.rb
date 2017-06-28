require "spec_helper"

describe "BrDanfe generated pdf files" do
  let(:base_dir) { "./spec/fixtures/"}
  let(:output_pdf) { "#{base_dir}output.pdf" }

  before { File.delete(output_pdf) if File.exist?(output_pdf) }

  it "renders a basic NF-e with namespace" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_ns.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_with_ns.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders another basic NF-e without namespace" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_without_ns.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_without_ns.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders a NF-e having FCI in its items" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_fci.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_with_fci.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders a Simples Nacional NF-e using CSOSN" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_simples_nacional.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_simples_nacional.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders a NF-e with extra volumes" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_extra_volumes.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_with_extra_volumes.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders a NF-e with logo" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_logo.xml"))
    danfe.options.logo_path = "./spec/fixtures/nfe_with_logo.xml.logo.png"
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_with_logo.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end

  it "renders a NF-e with CPF" do
    expect(File.exist?(output_pdf)).to be_false

    danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_cpf.xml"))
    danfe.save_pdf output_pdf

    expect("#{base_dir}nfe_with_cpf.xml.fixture.pdf").to be_same_file_as(output_pdf)
  end
end
