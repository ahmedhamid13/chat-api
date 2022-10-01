# frozen_string_literal: true

module Api
  module V1
    class ChatsController < Api::V1::ApiController
      include Api::V1::Chat
      before_action :set_application
      before_action :set_chat, only: %i[show update destroy]

      # GET /api/v1/applications/:token/chats
      def index
        @pagy, @chats = pagy(@application.chats)

        render json: { chats: chats_json(@chats, @includes), pagy: pagy_json(@pagy, @includes) }
      end

      # GET /api/v1/applications/:token/chats/1
      def show
        render json: { chat: chat_json(@chat, @includes) }
      end

      # POST /api/v1/applications/:token/chats
      def create
        ::Chat.with_advisory_lock('chat_lock') do
          @chat = Chat.new(chat_params)

          if @chat.save
            render json: { chat: chat_json(@chat, @includes) }, status: :created
          else
            render json: @chat.errors, status: :unprocessable_entity
          end
        end
      end

      # PATCH/PUT /api/v1/applications/:token/chats/1
      def update
        @chat.with_lock do
          if @chat.update(chat_params)
            render json: { chat: chat_json(@chat, @includes) }
          else
            render json: @chat.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /api/v1/applications/:token/chats/1
      def destroy
        @chat.destroy
      end

      private

      def set_application
        @application = ::SystemApplication.includes(:chats).find_by_token!(params[:application_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_chat
        @chat = @application.chats.find_by_number!(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chat_params
        # params.require(:chat).permit(:application_id).merge(application: @application)
        { system_application: @application }
      end
    end
  end
end
