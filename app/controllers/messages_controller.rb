class MessagesController < InheritedResources::Base
  before_filter :load_user

  def index
    @messages = current_user.messages
  end

  def show
  end

  def new
    @message = message.new
  end

  def edit
  end

  def create
    @message = current_user.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to user_messages_path(current_user), notice: 'message was successfully created.' }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to user_message_path(current_user, @message), notice: 'message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end




  private
  def load_user
    @user = User.find(params[:user_id] || params[:id]) || current_user
  end
end
