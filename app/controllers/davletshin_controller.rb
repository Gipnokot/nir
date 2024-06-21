class DavletshinController < ApplicationController
    def index
        @students_publications = fetch_students_publications
        respond_to do |format|
          format.html
          format.csv { send_data generate_csv(@students_publications), filename: "students_publications.csv" }
        end
      end
    
      private
    
      def fetch_students_publications
        student_id = params[:student_id]
        Author
          .joins(nir_authors: :nir)
          .where(nir_authors: { author_id: student_id }, status: 'студент')
          .select('authors.lastname', 'authors.name', 'authors.fathername', 'nirs.title', 'nirs.dtr', 'nirs.doi', 'nirs.href', 'nirs.output')
      end
         
    
      def generate_csv(data)
        CSV.generate(headers: true) do |csv|
            csv << ['Фамилия', 'Имя', 'Отчество', 'Название НИР', 'Дата публикации', 'DOI', 'Ссылка на пуликацию', 'Результат публикации']
          data.each do |publication|
            csv << [
              publication.lastname,
              publication.name,
              publication.fathername,
              publication.title,
              publication.dtr,
              publication.doi,
              publication.href,
              publication.output
            ]
          end
        end
      end
    end
