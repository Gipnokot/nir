class NirsController < ApplicationController
  def index
    @nirs = Nir.all
  end

  def new
    @nir = Nir.new
    @students = Author.where(status: 'студент')
    @advisers = Author.where(status: 'преподаватель')
  end

  def destroy
    @nir = Nir.find(params[:id])
    @nir.nir_authors.destroy_all # Удаление всех связанных записей из таблицы nir_authors
    @nir.destroy # Удаление записи из таблицы nirs
    redirect_to nirs_path, notice: 'Научная публикация успешно удалена'
  end

  def edit
    logger.debug "params[:id]: #{params[:id]}" # Debug line to print the id
    @nir = Nir.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to nirs_path, alert: "Научная публикация не найдена"
  end

  def create
    @nir = Nir.new(nir_params.except(:author_ids, :percent))
    if @nir.save
      params[:author_ids]&.each_with_index do |author_id, i|
        next unless author_id.present? && params[:percent][i].present?
        nir_author = NirAuthor.new(nir_id: @nir.id, author_id: author_id, percent: params[:percent][i])
        nir_author.save
      end
      redirect_to new_nir_path, notice: 'Научная публикация успешно добавлена'
    else
      @students = Author.where(status: 'студент')
      @advisers = Author.where(status: 'преподаватель')
      render :new
    end
  end

  def update
    @nir = Nir.find(params[:id])
    if @nir.update(nir_params)
      redirect_to nirs_path, notice: 'Научная публикация успешно обновлена'
    else
      render :edit
    end
  end

  private

  def nir_params
    params.require(:nir).permit(:title, :dtr, :nirtype, :volume, :doi, :core_rinz, :rinz, :scopus, :webofscience, :vak, :id_adviser, :href, :output, author_ids: [], percent: [])
  end
end
