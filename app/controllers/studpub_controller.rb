# app/controllers/studpub_controller.rb
require 'csv'

class StudpubController < ApplicationController
  def index
    @students_publications = Author
                             .joins(nir_authors: :nir)
                             .where(status: 'студент')
                             .select('authors.lastname', 'authors.name', 'authors.fathername', 'nirs.title', 'nirs.dtr', 'nirs.doi', 'nirs.href', 'nirs.output')

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@students_publications), filename: "students_publications_#{Time.zone.now.to_date}.csv" }
    end
  end

  private

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
