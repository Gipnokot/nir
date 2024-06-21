class NirController < ApplicationController
    def index
    end
    TYPES = [
        'article',
        'thesis',
        'monograph',
        'patent',
        'program',
        'database',
        'book'
      ].freeze
end
