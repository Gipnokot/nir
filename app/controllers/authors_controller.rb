class AuthorsController < ApplicationController
    def new
      @author = Author.new
      @cathedras = Cathedra.all
    end
  
    def create
      @author = Author.new(author_params)
      if @author.save
        redirect_to new_author_path, notice: 'Автор успешно добавлен'
      else
        @cathedras = Cathedra.all
        render :new
      end
    end
  
    private
  
    def author_params
      params.require(:author).permit(:lastname, :name, :fathername, :status, :cathedra_id)
    end
  end
  