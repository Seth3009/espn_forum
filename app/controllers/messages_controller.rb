class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all.order("created_at DESC")
  end

  def show
    
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path, alert: 'Message was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @message.destroy
      redirect_to root_path, alert: 'Message was successfully deleted.'
    else
      render @message
    end
  end

  private
    def message_params
      params.require(:message).permit(:title, :description)
    end

    def find_message
      @message = Message.find(params[:id])
    end
end
