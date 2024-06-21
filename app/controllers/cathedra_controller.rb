require 'csv'

class CathedraController < ApplicationController
  before_action :set_publication, only: [:edit, :update, :destroy]

  def index
    @cathedras = Cathedra.all
    @selected_cathedra = params[:cathedra_id]

    if @selected_cathedra.present?
      @cathedra_publications = fetch_cathedra_publications(@selected_cathedra)
    else
      @cathedra_publications = []
    end

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@cathedra_publications), filename: "cathedra_publications_#{Time.zone.now.to_date}.csv" }
    end
  end

  def edit
    @publication = Nir.find(params[:id])
    @cathedras = Cathedra.all
  end

  def update
    @publication = Nir.find(params[:id])
    ActiveRecord::Base.transaction do
      @publication.update!(publication_params)
      @publication.authors.each do |author|
        author.update!(author_params(author.id))
      end
    end

    redirect_to cathedra_path, notice: 'Publication was successfully updated.'
  rescue ActiveRecord::RecordInvalid
    render :edit
  end

  def destroy
    @publication = Nir.find(params[:id])
    @publication.destroy
    redirect_to cathedra_path, notice: 'Публикация успешно удалена.'
  end

  private

  def set_publication
    @publication = Nir.find(params[:id])
  end

  def publication_params
    params.require(:nir).permit(:title, :dtr, :doi, :href, :output)
  end

  def author_params(author_id)
    params.require(:author).permit(:lastname, :name, :fathername).merge(id: author_id)
  end

  def fetch_cathedra_publications(cathedra_id)
    Author
      .joins('JOIN nir_authors na ON authors.author_id = na.author_id')
      .joins('JOIN nirs n ON na.nir_id = n.nir_id')
      .joins('JOIN cathedras c ON authors.cathedra_id = c.cathedra_id')
      .where("c.cathedra_id = ? AND authors.status = 'преподаватель'", cathedra_id)
      .select('authors.lastname', 'authors.name', 'authors.fathername', 'n.nir_id', 'n.title', 'n.dtr', 'n.doi', 'n.href', 'n.output')
  end

  def generate_csv(data)
    CSV.generate(headers: true) do |csv|
      csv << ['Фамилия', 'Имя', 'Отчество', 'Название НИР', 'Дата публикации', 'DOI', 'Ссылка на пуликацию', 'Результат публикации']

      data.each do |publication|
        csv << [
          publication.lastname,
          publication.name,
          publication.fathername,
          publication.nir_id,
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
