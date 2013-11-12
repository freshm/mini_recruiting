class CreatePdfFooters < ActiveRecord::Migration
  def change
    create_table :pdf_footers do |t|
      t.text :footer, default: "Here's a sample footer. Add your own footer here for the PDF or delete it."

      t.timestamps
    end
    PdfFooter.create()
  end
end
