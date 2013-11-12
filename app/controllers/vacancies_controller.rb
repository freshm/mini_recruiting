class VacanciesController < ApplicationController
  # before_filter :redirect_admin
  # GET /vacancies
  # GET /vacancies.json
  def index
    @vacancies = Vacancy.page(params[:page]).per(30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vacancies }
    end
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
    @vacancy = Vacancy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vacancy }
    end
  end

  # GET /vacancies/new
  # GET /vacancies/new.json
  def new
    @vacancy = Vacancy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vacancy }
    end
  end

  # GET /vacancies/1/edit
  def edit
    @vacancy = Vacancy.find(params[:id])
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    @vacancy = Vacancy.new(params[:vacancy])

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render json: @vacancy, status: :created, location: @vacancy }
      else
        format.html { render action: "new" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vacancies/1
  # PUT /vacancies/1.json
  def update
    @vacancy = Vacancy.find(params[:id])

    respond_to do |format|
      if @vacancy.update_attributes(params[:vacancy])
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy

    respond_to do |format|
      format.html { redirect_to vacanies_url }
      format.json { head :no_content }
    end
  end

  def new_pdf
    @vacancy = Vacancy.find(params[:id])

    # PDFKit.new takes the HTML and any options for wkhtmltopdf
    # run `wkhtmltopdf --extended-help` for a full list of options
    

    respond_to do |format|
      format.html
      format.pdf {
        kit = PDFKit.new(vacancy_generate_html_for_pdf(@vacancy), :page_size => 'Letter')
        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css"
        pdf = kit.to_pdf
        send_data(kit.to_pdf, :filename => "#{@vacancy.title}_Vacancy.pdf", :type => 'application/pdf')
      }
    end
  end

  def generate_pdf
    @vacancy = Vacancy.find(params[:id])
    footer = params[:footer]
    object = [@vacancy, footer]


    respond_to do |format|
      format.html
      format.pdf {
        kit = PDFKit.new(vacancy_generate_html_for_pdf(object), :page_size => 'Letter')
        kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/application.css"
        pdf = kit.to_pdf
        send_data(kit.to_pdf, :filename => "#{@vacancy.title}_Vacancy.pdf", :type => 'application/pdf')
      }
    end
  end

  private

  def redirect_admin
    redirect_to admin_vacancies_path if user_signed_in? && current_user.admin?
  end
end
