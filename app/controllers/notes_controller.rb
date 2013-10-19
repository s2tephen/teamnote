class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = current_user.notes.order('updated_at desc, title asc')
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
    @users = User.where.not(id: current_user.id)
  end

  # GET /notes/1/edit
  def edit
    @users = User.where.not(id: current_user.id)
  end

  # POST /notes
  # POST /notes.json
  def create
    users = note_params['user_ids'][1..-1]
    @note = Note.new(note_params.except('user_ids'))

    respond_to do |format|
      if @note.save
        Permission.create(:user_id => current_user.id, :note_id => @note.id)
        users.each { |user| Permission.where(:user_id => user, :note_id => @note.id).first_or_create }
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new', :layout => 'noteform' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    users = note_params['user_ids'][1..-1]
    users << current_user.id
    permissions = Permission.where(:note_id => @note.id).where.not(:user_id => users)

    respond_to do |format|
      if @note.update(note_params.except('user_ids'))
        unless permissions.empty?
          permissions.each { |p| Permission.destroy(p.id) }
        end
        users.each { |user| Permission.where(:user_id => user, :note_id => @note.id).first_or_create }
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', :layout => 'noteform' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.friendly.find(params[:id])
      redirect_to root_path unless @note.users.include?(current_user)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :content, :user_ids => [])
    end
end
