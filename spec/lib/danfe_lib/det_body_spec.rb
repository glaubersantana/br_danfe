require "spec_helper"

describe BrDanfe::DanfeLib::DetBody do
  let(:base_dir) { "./spec/fixtures/nfe/lib/" }
  let(:output_pdf) { "#{base_dir}output.pdf" }

  let(:pdf) { BrDanfe::DanfeLib::Document.new }
  let(:xml) { BrDanfe::DanfeLib::XML.new(xml_as_string) }

  let(:options) do
    { unit_price_precision: 2, quantity_precision: 2 }
  end

  let(:options_custom_unit_price_precision) do
    { unit_price_precision: 4, quantity_precision: 2 }
  end

  let(:options_custom_quantity_precision) do
    { unit_price_precision: 2, quantity_precision: 4 }
  end

  subject { described_class.new(pdf, xml, options) }

  describe "#render" do
    before do
      subject.render
      File.delete(output_pdf) if File.exist?(output_pdf)
    end

    context "with CSOSN" do
      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>1</cProd>
                <xProd>Produto com CSOSN 101 - Nacional</xProd>
                <NCM>12345678</NCM>
                <CFOP>5101</CFOP>
                <uCom>UN</uCom>
                <qCom>2.0000</qCom>
                <vUnCom>1.0100000000</vUnCom>
                <vProd>2.02</vProd>
              </prod>
              <imposto>
                <ICMS>
                  <ICMSSN101>
                    <orig>0</orig>
                    <CSOSN>101</CSOSN>
                  </ICMSSN101>
                </ICMS>
              </imposto>
            </det>
            <det nItem="2">
              <prod>
                <cProd>2</cProd>
                <xProd>Produto com CSOSN 102 - Estrangeiro</xProd>
                <NCM>23456789</NCM>
                <CFOP>5101</CFOP>
                <uCom>UN</uCom>
                <qCom>4.0000</qCom>
                <vUnCom>1.0200000000</vUnCom>
                <vProd>4.08</vProd>
              </prod>
              <imposto>
                <ICMS>
                  <ICMSSN102>
                    <orig>1</orig>
                    <CSOSN>102</CSOSN>
                  </ICMSSN102>
                </ICMS>
              </imposto>
            </det>
            <det nItem="3">
              <prod>
                <cProd>3</cProd>
                <xProd>Produto Com Csosn 201</xProd>
                <NCM>45678901</NCM>
                <CFOP>5401</CFOP>
                <uCom>UN</uCom>
                <qCom>6.0000</qCom>
                <vUnCom>1.0300000000</vUnCom>
                <vProd>6.18</vProd>
              </prod>
              <imposto>
              <ICMS>
                <ICMSSN201>
                  <orig>0</orig>
                  <CSOSN>201</CSOSN>
                  <pMVAST>24.0000</pMVAST>
                  <vBCST>7.66</vBCST>
                  <pICMSST>17.0000</pICMSST>
                  <vICMSST>0.25</vICMSST>
                </ICMSSN201>
              </ICMS>
              </imposto>
            </det>
            <det nItem="4">
              <prod>
                <cProd>8</cProd>
                <xProd>Produto com CSOSN 900 - Com ICMS</xProd>
                <NCM>34567890</NCM>
                <CFOP>5201</CFOP>
                <uCom>UN</uCom>
                <qCom>16.0000</qCom>
                <vUnCom>1.0800000000</vUnCom>
                <vProd>17.28</vProd>
              </prod>
              <imposto>
                <ICMS>
                  <ICMSSN900>
                    <orig>0</orig>
                    <CSOSN>900</CSOSN>
                    <vBC>9.87</vBC>
                    <pICMS>8.76</pICMS>
                    <vICMS>7.65</vICMS>
                  </ICMSSN900>
                </ICMS>
              </imposto>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-csosn.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "with CST" do
      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>REF 04</cProd>
                <xProd>Produto com CST 00 - Nacional - ICMS - IPI</xProd>
                <NCM>90303329</NCM>
                <EXTIPI>00</EXTIPI>
                <CFOP>5101</CFOP>
                <uCom>PC</uCom>
                <qCom>1.00</qCom>
                <vUnCom>49.23</vUnCom>
                <vProd>49.23</vProd>
                <xPed>98001921</xPed>
                <nItemPed>10</nItemPed>
              </prod>
              <imposto>
                <ICMS>
                  <ICMS00>
                    <orig>0</orig>
                    <CST>00</CST>
                    <modBC>3</modBC>
                    <vBC>49.23</vBC>
                    <pICMS>12.00</pICMS>
                    <vICMS>5.90</vICMS>
                  </ICMS00>
                </ICMS>
                <IPI>
                  <cEnq>999</cEnq>
                  <IPITrib>
                    <CST>50</CST>
                    <vBC>49.23</vBC>
                    <pIPI>5.00</pIPI>
                    <vIPI>2.46</vIPI>
                  </IPITrib>
                </IPI>
              </imposto>
            </det>
            <det nItem="2">
              <prod>
                <cProd>REF 05</cProd>
                <xProd>Produto com CST 00 - Estrangeiro - ICMS - IPI</xProd>
                <NCM>90303329</NCM>
                <EXTIPI>00</EXTIPI>
                <CFOP>5101</CFOP>
                <uCom>PC</uCom>
                <qCom>1.00</qCom>
                <vUnCom>49.23</vUnCom>
                <vProd>49.23</vProd>
                <xPed>98001921</xPed>
                <nItemPed>10</nItemPed>
              </prod>
              <imposto>
                <ICMS>
                  <ICMS00>
                    <orig>1</orig>
                    <CST>00</CST>
                    <modBC>3</modBC>
                    <vBC>49.23</vBC>
                    <pICMS>12.00</pICMS>
                    <vICMS>5.90</vICMS>
                  </ICMS00>
                </ICMS>
                <IPI>
                  <cEnq>999</cEnq>
                  <IPITrib>
                    <CST>50</CST>
                    <vBC>49.23</vBC>
                    <pIPI>5.00</pIPI>
                    <vIPI>2.46</vIPI>
                  </IPITrib>
                </IPI>
              </imposto>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-cst.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "with FCI" do
      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>REF 06</cProd>
                <xProd>Produto com FCI</xProd>
                <NCM>90303329</NCM>
                <EXTIPI>00</EXTIPI>
                <CFOP>5101</CFOP>
                <uCom>PC</uCom>
                <qCom>1.00</qCom>
                <vUnCom>49.23</vUnCom>
                <vProd>49.23</vProd>
                <nFCI>12232531-74B2-4FDD-87A6-CF0AD3E55386</nFCI>
              </prod>
              <imposto>
                <ICMS>
                  <ICMS00>
                    <orig>0</orig>
                    <CST>00</CST>
                  </ICMS00>
                </ICMS>
              </imposto>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-fci.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "with ICMS ST" do
      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>3</cProd>
                <xProd>Produto Com Csosn 201 - ICMS ST</xProd>
                <NCM>45678901</NCM>
                <CFOP>5401</CFOP>
                <uCom>UN</uCom>
                <qCom>6.0000</qCom>
                <vUnCom>1.0300000000</vUnCom>
                <vProd>6.18</vProd>
              </prod>
              <imposto>
              <ICMS>
                <ICMSSN201>
                  <orig>0</orig>
                  <CSOSN>201</CSOSN>
                  <pMVAST>24.0000</pMVAST>
                  <vBCST>7.66</vBCST>
                  <pICMSST>17.0000</pICMSST>
                  <vICMSST>0.25</vICMSST>
                </ICMSSN201>
              </ICMS>
              </imposto>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-icms_st.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "with DIFAL" do
      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>3</cProd>
                <xProd>Produto Com DIFAL</xProd>
                <NCM>45678901</NCM>
                <CFOP>5401</CFOP>
                <uCom>UN</uCom>
                <qCom>6.0000</qCom>
                <vUnCom>1.1312000000</vUnCom>
                <vProd>6.79</vProd>
              </prod>
              <imposto>
                <ICMSUFDest>
                  <vBCUFDest>12000.53</vBCUFDest>
                  <pFCPUFDest>17.90</pFCPUFDest>
                  <pICMSUFDest>21.51</pICMSUFDest>
                  <pICMSInter>12.45</pICMSInter>
                  <pICMSInterPart>40</pICMSInterPart>
                  <vFCPUFDest>11002.35</vFCPUFDest>
                  <vICMSUFDest>19282.47</vICMSUFDest>
                  <vICMSUFRemet>12344.56</vICMSUFRemet>
                </ICMSUFDest>
              </imposto>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-difal.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "when the unit price of the product has a custom precision" do
      subject { described_class.new(pdf, xml, options_custom_unit_price_precision) }

      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>3</cProd>
                <xProd>Produto Com Csosn 201 - ICMS ST</xProd>
                <NCM>45678901</NCM>
                <CFOP>5401</CFOP>
                <uCom>UN</uCom>
                <qCom>6.0000</qCom>
                <vUnCom>1.1312000000</vUnCom>
                <vProd>6.79</vProd>
              </prod>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-unit_price_with_custom_precision.pdf").to have_same_content_of file: output_pdf
      end
    end

    context "when the quantity of the product has a custom precision" do
      subject { described_class.new(pdf, xml, options_custom_quantity_precision) }

      let(:xml_as_string) do
        <<-eos
        <NFe xmlns="http://www.portalfiscal.inf.br/nfe">
          <infNFe Id="NFe25111012345678901234550020000134151000134151" versao="2.00">
            <det nItem="1">
              <prod>
                <cProd>3</cProd>
                <xProd>Produto Com Csosn 201 - ICMS ST</xProd>
                <NCM>45678901</NCM>
                <CFOP>5401</CFOP>
                <uCom>UN</uCom>
                <qCom>6.4545</qCom>
                <vUnCom>1.0300000000</vUnCom>
                <vProd>6.65</vProd>
              </prod>
            </det>
          </infNFe>
        </NFe>
        eos
      end

      it "renders xml to the pdf" do
        expect(File.exist?(output_pdf)).to be_falsey

        pdf.render_file output_pdf

        expect("#{base_dir}det_body#render-quantity_with_custom_precision.pdf").to have_same_content_of file: output_pdf
      end
    end
  end
end