module BrDanfe
  module DanfeLib
    class DetBody
      def initialize(pdf, xml)
        @pdf = pdf
        @xml = xml
      end

      def render
        @pdf.font_size(6) do
          @pdf.itable 7.64, 21.50, 0.25, 18.17,
            products,
            :column_widths => column_widths,
            :cell_style => {:padding => 2, :border_width => 0} do |table|
              table.column(6..15).style(:align => :right)
              table.column(0..15).border_width = 1
              table.column(0..15).borders = [:bottom]
            end
        end
      end

      private
      def products
        @xml.collect("xmlns", "det") { |det| product(det) }
      end

      def product(det)
        [
          det.css("prod/cProd").text,
          Xprod.new(det).render,
          det.css("prod/NCM").text,
          Cst.to_danfe(det),
          det.css("prod/CFOP").text,
          det.css("prod/uCom").text,
          numerify(det, "prod/qCom"),
          numerify(det, "prod/vUnCom"),
          numerify(det, "prod/vDesc"),
          numerify(det, "prod/vProd"),
          numerify(det, "ICMS/*/vCredICMSSN"),
          numerify(det, "ICMS/*/vBC"),
          numerify(det, "ICMS/*/vICMS"),
          numerify(det, "IPI/*/vIPI"),
          numerify(det, "ICMS/*/pICMS"),
          numerify(det, "IPI/*/pIPI")
        ]
      end

      def numerify(det, xpath)
        Helper.numerify(det.css("#{xpath}").text)
      end

      def column_widths
        {
          0  => 2.00.cm,
          1  => 4.80.cm,
          2  => 1.10.cm,
          3  => 0.80.cm,
          4  => 0.80.cm,
          5  => 0.80.cm,
          6  => 1.00.cm, # qCom
          7  => 1.20.cm, # vUnCom
          8  => 1.20.cm, # vDesc
          9  => 1.20.cm, # vProd
          10 => 1.00.cm, # vCredICMSSN
          11 => 1.00.cm,
          12 => 1.00.cm,
          13 => 0.90.cm,
          14 => 0.90.cm,
          15 => 0.86.cm
        }
      end
    end
  end
end
