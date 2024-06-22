class RedaktirovanieController < ApplicationController
    def index
      @publications = Nir.all
    end
  end
  