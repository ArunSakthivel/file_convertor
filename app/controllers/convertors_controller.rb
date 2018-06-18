require 'libreconv'
class ConvertorsController < ApplicationController

  ##
  # File encode code:
  # Base64.encode64(File.read(<xlsx file path>))
  def create
    # File decoded and save it in the local path
    File.open("#{Rails.root}/public/#{params[:file_convertor][:filename]}.xlsx", 'wb') do |f|
      f.write(Base64.decode64(params[:file_convertor]["file"]))
    end

    # file_conversion = FileConversion.new(tempfile)
    # download_file_path = file_conversion.convert
    
    # File conversion process from xlsx to pdf
    Libreconv.convert("#{Rails.root}/public/#{params[:file_convertor][:filename]}.xlsx", "#{Rails.root}/public/file_conversion/document.pdf")
    download_file_path = "#{Rails.root}/public/file_conversion/document.pdf"

    
    render json: {download_file_path: download_file_path}, status: :created, location: "Done"
  end
end
