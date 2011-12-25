module CertificateBuilder
  PDF_TEMPLATE = "#{::Rails.root.to_s}/templates/default.pdf"
  PDF_FONT     = "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
  PDF_OPTIONS  = {:template => PDF_TEMPLATE}
  DATE_FORMAT  = "%d/%m/%Y"
  AWARD_TEXT   = "In recognition of %s valuable contributions in promoting interfaith cooperation, peace and understanding."

  module Extensions
    def set_background(image_path, opts = {})
      options = {:position => :center, :vposition => :center}.merge(opts)
      image(image_path, options)
    end

    def boxed_annotation(text, options = {})
      fill_color(options.delete(:fill_color) || '808080')
      text_box(text, options)
    end

    def award_text(cr)
      AWARD_TEXT % {"male" => "his", "female" => "her"}.fetch(cr.receiver_gender, "your")
    end
  end

  Prawn::Document.extensions << Extensions

  def build(certificate_request)
    pdf = Prawn::Document.new(PDF_OPTIONS) do
      # start_new_page(:size => 'LETTER', :layout => :landscape)
      go_to_page(1)

      font(PDF_FONT)
      #set_background(PDF_BACKGROUND)

      boxed_annotation(certificate_request.receiver_name, {
        :at         => [20, 310],
        :width      => 290,
        :height     => 48,
        :size       => 24,
        :align      => :right,
        :valign     => :center,
        :fill_color => '606060',
      })

      boxed_annotation(award_text(certificate_request), {
        :at         => [10, 400],
        :width      => 300,
        :heigth     => 60,
        :size       => 16,
        :align      => :right,
        :valign     => :center,
        :fill_color => 'a0a0a0',
      })

      boxed_annotation(certificate_request.sender_name, {
        :at         => [60, 125],
        :width      => 290,
        :height     => 24,
        :size       => 16,
        :align      => :left,
        :valign     => :center,
        :fill_color => 'a0a0a0',
      })

      boxed_annotation(certificate_request.created_at.strftime(DATE_FORMAT), {
        :at         => [220, 90],
        :width      => 90,
        :height     => 16,
        :size       => 12,
        :align      => :center,
        :valign     => :center,
        :fill_color => 'a0a0a0',
      })
    end
    pdf.render
  end

  module_function :build
end
