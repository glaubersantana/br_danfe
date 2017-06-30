module BrDanfe
  class DetHeader
    def initialize(pdf, xml)
      @pdf = pdf
      @xml = xml
    end

    def render
      @pdf.ititle 0.42, 10.00, 0.25, 17.45, "det.title"

      column(2.00, 0.25, "prod.cProd")
      column(4.80, 2.25, "prod.xProd")
      column(1.10, 7.05, "prod.NCM")
      column(0.80, 8.15, "ICMS.CST")
      column(0.80, 8.95, "prod.CFOP")
      column(0.80, 9.75, "prod.uCom")
      column(1.00, 10.55, "prod.qCom")
      column(1.20, 11.55, "prod.vUnCom")
      column(1.20, 12.75, "prod.vDesc")
      column(1.20, 13.95, "prod.vProd")
      column(1.00, 15.15, "ICMS.vCredICMSSN")
      column(1.00, 16.15, "ICMS.vBC")
      column(1.00, 17.15, "ICMS.vICMS")
      column(0.90, 18.15, "IPI.vIPI")
      column(0.90, 19.05, "ICMS.pICMS")
      column(0.86, 19.95, "IPI.pIPI")


      @pdf.horizontal_line 0.25.cm, 20.83.cm, :at => Helper.invert(18.17.cm)
    end

    private
    def column(w, x, title)
      @pdf.ibox 7.97, w, x, 17.87, I18n.t("danfe.det.#{title}")
    end
  end
end
