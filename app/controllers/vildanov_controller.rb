require 'csv'
class VildanovController < ApplicationController
    def index
      @teachers_publications = fetch_teachers_publications
      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@teachers_publications), filename: "teachers_publications.csv" }
      end
    end
  
    private
  
    def fetch_teachers_publications
      teacher_id = params[:teacher_id]
      Author
        .joins(nir_authors: :nir)
        .where(nir_authors: { author_id: teacher_id })
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
