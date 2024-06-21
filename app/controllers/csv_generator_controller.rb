class CsvGeneratorController < ApplicationController
  def generate_csv
    controller_name = params[:controller]
    case controller_name
    when 'teacher'
      generate_csv_for(Teacher)
    when 'vildanov'
      generate_csv_for(Vildanov)
    when 'cathedra'
      generate_csv_for(Cathedra)
    when 'davletshin'
      generate_csv_for(Davletshin)
    when 'students'
      generate_csv_for(Student)
    when 'allpub'
      generate_csv_for(Allpub)
    else
      render plain: 'Undefined controller', status: :not_found
      return
    end
  end

  private

  def generate_csv_for(model)
    data = model.all
    csv_data = generate_csv_data(data)
    send_data csv_data, filename: "data-#{Date.today}.csv", type: 'text/csv; charset=utf-8'
  end

  def generate_csv_data(data)
    CSV.generate(headers: true) do |csv|
      csv << data.column_names
      data.each do |record|
        csv << record.attributes.values
      end
    end
  end
end
