class StudentsController < ApplicationController
  def index
    @teachers = Author.where(status: 'преподаватель').order(:lastname, :name, :fathername)
    teacher_id = params[:teacher_id]

    respond_to do |format|
      format.html do
        if teacher_id.present?
          @publications = fetch_teacher_publications(teacher_id)
        end
      end
      format.csv do
        if teacher_id.present?
          @publications = fetch_teacher_publications(teacher_id)
          send_data generate_csv(@publications), filename: "teacher_publications.csv"
        end
      end
    end
  end

  private

  def fetch_teacher_publications(teacher_id)
    Nir.joins(nir_authors: :author)
      .joins("JOIN nir_authors AS na2 ON nirs.nir_id = na2.nir_id")
      .joins("JOIN authors AS a2 ON na2.author_id = a2.author_id")
      .where(authors: { author_id: teacher_id })
      .where('a2.status = ?', 'студент')
      .select('authors.lastname AS teacher_lastname, authors.name AS teacher_name, authors.fathername AS teacher_fathername,
              a2.lastname AS student_lastname, a2.name AS student_name, a2.fathername AS student_fathername,
              nirs.title, nirs.dtr, nirs.doi, nirs.href, nirs.output, nir_authors.percent')
  end

  def generate_csv(publications)
    CSV.generate(headers: true) do |csv|
      csv << ["Teacher Lastname", "Teacher Name", "Teacher Fathername", "Student Lastname", "Student Name", "Student Fathername", "Title", "DTR", "DOI", "Href", "Output", "Percent"]

      publications.each do |publication|
        csv << [
          publication.teacher_lastname,
          publication.teacher_name,
          publication.teacher_fathername,
          publication.student_lastname,
          publication.student_name,
          publication.student_fathername,
          publication.title,
          publication.dtr,
          publication.doi,
          publication.href,
          publication.output,
          publication.percent
        ]
      end
    end
  end
end
