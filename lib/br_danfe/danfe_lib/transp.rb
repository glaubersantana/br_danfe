module BrDanfe
  module DanfeLib
    class Transp
      def self.render(pdf, xml)
        pdf.ititle 0.42, 10.00, 0.25, 15.33, "transporta.title"

        pdf.lbox 0.85, 9.02, 0.25, 15.75, xml, "transporta/xNome"
        pdf.ibox 0.85, 2.79, 9.27, 15.75, I18n.t("danfe.transp.modFrete.title"), xml["transp/modFrete"] == "0" ? I18n.t("danfe.transp.modFrete.emitter") : I18n.t("danfe.transp.modFrete.recipient")
        pdf.lbox 0.85, 1.78, 12.06, 15.75, xml, "veicTransp/RNTC"
        pdf.ibox 0.85, 2.29, 13.84, 15.75, I18n.t("danfe.veicTransp.placa"), Plate.format(xml["veicTransp/placa"])
        pdf.lbox 0.85, 0.76, 16.13, 15.75, xml, "veicTransp/UF"
        pdf.lbox 0.85, 3.94, 16.89, 15.75, xml, "transporta/CNPJ"
        #pdf.lbox 0.85, 9.02, 0.25, 16.6, xml, "transporta/xEnder"
        #pdf.lbox 0.85, 6.86, 9.27, 16.6, xml, "transporta/xMun"
        #pdf.lbox 0.85, 0.76, 16.13, 16.6, xml, "transporta/UF"
        #pdf.lbox 0.85, 3.94, 16.89, 16.6, xml, "transporta/IE"

        pdf.lbox 0.85, 2.92, 0.25, 16.60, xml, "vol/qVol"
        pdf.lbox 0.85, 3.05, 3.17, 16.60, xml, "vol/esp"
        pdf.lbox 0.85, 3.05, 6.22, 16.60, xml, "vol/marca"
        pdf.lbox 0.85, 4.83, 9.27, 16.60, xml, "vol/nVol"
        pdf.lnumeric 0.85, 3.43, 14.10, 16.60, xml, "vol/pesoB", { :decimals => 3 }
        pdf.lnumeric 0.85, 3.30, 17.53, 16.60, xml, "vol/pesoL", { :decimals => 3 }
      end
    end
  end
end
