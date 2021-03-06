module BrDanfe
  module DanfeLib
    class Dup
      def initialize(pdf, xml)
        @pdf = pdf
        @xml = xml
      end

      def render
        @pdf.ititle 0.42, 10.00, 0.25, 11.12, "dup.title"
        @pdf.ibox 0.85, 20.57, 0.25, 11.51

        x = 0.25
        y = 11.51
        @xml.collect("xmlns", "dup") do |det|
          render_dup(det, x, y)
          #x += 2.30
          x += 2.80
        end
      end

      private
      def render_dup(det, x, y)
        #@pdf.ibox 0.85, 2.12, x, y, "", I18n.t("danfe.dup.nDup"), italic
        #@pdf.ibox 0.85, 2.12, x + 0.70, y, "", det.css("nDup").text, normal
        #@pdf.ibox 0.85, 2.12, x, y + 0.20, "", I18n.t("danfe.dup.dVenc"), italic

        #@pdf.ibox 0.85, 2.12, x + 0.70, y + 0.20, "", dtduplicata(det), normal

        #@pdf.ibox 0.85, 2.12, x, y + 0.40, "", I18n.t("danfe.dup.vDup"), italic
        #@pdf.inumeric 0.85, 1.25, x + 0.70, y + 0.40, "", det.css("vDup").text, normal

        @pdf.ibox 0.85, 2.32, x, y, "", I18n.t("danfe.dup.dVenc"), italic

        @pdf.ibox 0.85, 2.32, x + 1, y, "", dtduplicata(det), normal

        @pdf.ibox 0.85, 2.32, x, y + 0.30, "", I18n.t("danfe.dup.vDup"), italic
        @pdf.ibox 0.85, 2.32, x + 1, y + 0.30, "", "R$ #{Helper.numerify(det.css('vDup').text, 2)}", normal
      end

      def dtduplicata(det)
        dtduplicata = det.css("dVenc").text
        dtduplicata = dtduplicata[8,2] + "/" + dtduplicata[5, 2] + "/" + dtduplicata[0, 4]
        dtduplicata
      end

      def normal
        { :size => 8, :border => 0 }
      end

      def italic
        normal.merge({ :style => :italic })
      end
    end
  end
end
