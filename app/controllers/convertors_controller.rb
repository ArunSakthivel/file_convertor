require 'libreconv'
class ConvertorsController < ApplicationController

  def create

    #create a new tempfile named fileupload
      tempfile = Tempfile.new("fileupload")
      tempfile.binmode
      # #get the file and decode it with base64 then write it to the tempfile
      tempfile.write(Base64.decode64(params[:file_convertor]["file"]))

     # File.open("#{Rails.root}/public/#{params[:file_convertor][:filename]}.xls",'wb'){ |f|
     #  content = params[:file_convertor]["file"]
     #  content.gsub!('\\r', "\r")
     #  content.gsub!('\\n', "\n")
     #  f.write(Base64.decode64(content))
     #  f.close
     # }

    #check if file is within picture_path
    # if params[:picture][:picture_path]["file"]
    #   picture_path_params = params[:picture][:picture_path]
    #   #create a new tempfile named fileupload
    #   tempfile = Tempfile.new("fileupload")
    #   tempfile.binmode
    #   #get the file and decode it with base64 then write it to the tempfile
    #   tempfile.write(Base64.decode64(picture_path_params["file"]))

    #   #create a new uploaded file
    #   uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => picture_path_params["filename"], :original_filename => picture_path_params["original_filename"]) 

    #   #replace picture_path with the new uploaded file
    #   params[:picture][:picture_path] =  uploaded_file

    # end

    # @picture = Picture.new(params[:picture])

    # file_conversion = FileConversion.new(tempfile)
    # download_file_path = file_conversion.convert

    # p tempfile

    Libreconv.convert(tempfile, "#{Rails.root}/public/file_conversion/document.pdf")
    download_file_path = "#{Rails.root}/public/file_conversion/document.pdf"

    
    render json: {download_file_path: download_file_path}, status: :created, location: "Done"
  end
end
