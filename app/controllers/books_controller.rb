class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  load_and_authorize_resource
  handles_sortable_columns do |conf|
  #conf.indicator_text = {}
end

  def index
    order = sortable_column_order
    @books = Book.order(order)

    respond_to do |format|
     # raise format.inspect
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    #raise params.inspect
    @book = Book.find(params[:id])
     #html = render_to_string :layout => false 

    #html = render_to_string :layout => false 
   #kit = PDFKit.new(html, :page_size => 'Legal')
    #kit.stylesheets << RAILS_ROOT + '/public/stylesheets/scaffold.css'
   #send_data(kit.to_pdf, :filename => "#{@book.id}", :type => 'application/pdf')
  
    respond_to do |format|
     format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  def pdf_generate
    #  @book = Book.find(params[:id])
   # html = render_to_string :layout => false 

    html = render_to_string :layout => true , :action => "index", :formats => :html
    kit = PDFKit.new(html, :page_size => 'Legal')
    #kit.stylesheets << RAILS_ROOT + '/assets/stylesheets/application.css'
    kit.stylesheets << "#{Rails.root.join('app',"assets","stylesheets", "application.css")}"
    send_data(kit.to_pdf, :filename => "l", :type => 'application/pdf')
   # redirect_to book_path(:id=>@book.id)
  end
end
