# frozen_string_literal: true

RSpec.describe 'Blocks' do
  let(:pdf) { instance_double(PrawnHtml::PdfWrapper, advance_cursor: true, puts: true) }

  before do
    allow(pdf).to receive_messages(page_width: 540, page_height: 720)
    allow(PrawnHtml::PdfWrapper).to receive(:new).and_return(pdf)
    pdf_document = Prawn::Document.new(page_size: 'A4', page_layout: :portrait)
    PrawnHtml.append_html(pdf_document, html)
  end

  context 'with some content in an element div' do
    let(:html) { '<div>Some sample content...</div>' }

    it 'sends the expected buffer elements to Prawn pdf' do
      expect(pdf).to have_received(:puts).with(
        [{ size: TestUtils.default_font_size, text: "Some sample content..." }],
        { leading: TestUtils.adjust_leading },
        { bounding_box: nil, left_indent: 0 }
      )
    end
  end

  context 'with some content in an element p' do
    let(:html) { '<p>Some sample content...</p>' }

    it 'sends the expected buffer elements to Prawn pdf' do
      expect(pdf).to have_received(:puts).with(
        [{ size: TestUtils.default_font_size, text: "Some sample content..." }],
        { leading: TestUtils.adjust_leading },
        { bounding_box: nil, left_indent: 0 }
      )
    end
  end
end
