class Publication < ActiveRecord::Base
    belongs_to :author
    attr_accessor :lastname, :name, :fathername, :title, :dtr, :doi, :href, :output, :id
    def initialize(hash)
      @lastname = hash[:lastname]
      @name = hash[:name]
      @fathername = hash[:fathername]
      @title = hash[:title]
      @dtr = hash[:dtr]
      @doi = hash[:doi]
      @href = hash[:href]
      @output = hash[:output]
      @id = hash[:id]
    end
    def nir_id
        id
      end
      def author
        Author.find(author_id)
      end
  end