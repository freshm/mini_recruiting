class Admin::PdfFooterController < ApplicationController
	def edit
		@footer = PdfFooter.first
	end

	def update
		@footer = PdfFooter.find(1)

		respond_to do |format|
			if @footer.update_attributes(params[:pdf_footer])
				format.html { redirect_to admin_vacancies_path, notice: 'Footer was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @job_application.errors, status: :unprocessable_entity }
			end
		end
	end
end