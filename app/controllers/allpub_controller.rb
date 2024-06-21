class AllpubController < ApplicationController
    def index
      @cathedras = Cathedra.all
      if params[:cathedra_id].present?
        @selected_cathedra = Cathedra.find(params[:cathedra_id])
        @teachers = @selected_cathedra.authors.where(status: 'преподаватель')
      else
        @teachers = Author.where(status: 'преподаватель')
      end
  
      if params[:cathedra_id].present?
        cathedra = Cathedra.find(params[:cathedra_id])
        @student_publications = cathedra.authors.where(status: 'студент').joins(:nirs).where(nir_authors: { percent: 100 }).select('authors.lastname AS student_lastname, authors.name AS student_name, authors.fathername AS student_fathername, nirs.title AS publication_title, nirs.dtr AS publication_date, nirs.doi AS publication_doi, nirs.href AS publication_href, nirs.output AS publication_output').order('authors.lastname')
      else
        @student_publications = []
      end
  
      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@student_publications), filename: "student_publications.csv" }
      end
    end
  
    private
  
    def generate_csv(publications)
      CSV.generate(headers: true) do |csv|
        csv << ["Student Lastname", "Student Name", "Student Fathername", "Publication Title", "Publication Date", "Publication DOI", "Publication Href", "Publication Output"]
  
        publications.each do |publication|
          csv << [
            publication.student_lastname,
            publication.student_name,
            publication.student_fathername,
            publication.publication_title,
            publication.publication_date,
            publication.publication_doi,
            publication.publication_href,
            publication.publication_output
          ]
        end
      end
    end
  end
  