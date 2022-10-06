# frozen_string_literal: true

module Api
  module V1
    class MessagesController < Api::V1::ApiController
      include Api::V1::Message
      before_action :set_application
      before_action :set_chat
      before_action :set_message, only: %i[show update destroy]

      # GET /api/v1/applications/:token/chats/:number/messages
      def index
        if params[:q].present?
          @pagy, @messages = pagy_array(::Message.search(q: params[:q], chat_id: @chat.id))
        else
          @pagy, @messages = pagy(@chat.messages)
        end

        render json: { messages: messages_json(@messages, @includes), pagy: pagy_json(@pagy, @includes) }
      end

      # GET /api/v1/applications/:token/chats/:number/messages/1
      def show
        render json: { message: message_json(@message, @includes) }
      end

      # POST /api/v1/applications/:token/chats/:number/messages
      def create
        result = NewMessage.create(chat_id: @chat.id, body: message_params[:body])

        if result.success?
          render json: { message: message_json(result.value, @includes) }, status: :created
        else
          render json: result.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/applications/:token/chats/:number/messages/1
      def update
        @message.with_lock do
          if @message.update(message_params)
            render json: { message: message_json(@message, @includes) }
          else
            render json: @message.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /api/v1/applications/:token/chats/:number/messages/1
      def destroy
        @message.destroy
      end

      private

      def set_application
        @application = ::SystemApplication.includes(:chats).find_by_token!(params[:application_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_chat
        @chat = @application.chats.includes(:messages).find_by_number!(params[:chat_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = @chat.messages.find_by_number!(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:body).merge(chat: @chat)
      end
    end
  end
end
