module Api
  module V1
    class VerticalsController < ApplicationController
      before_action :authenticate_request!
      before_action :set_vertical, only: :destroy

      def index
        @verticals = current_user!.verticals
        render json: VerticalsRepresenter.new(@verticals).as_json
      end

      def create
        @vertical = current_user!.verticals.new(vertical_params)
        if @vertical.save
          render json: VerticalRepresenter.new(@vertical).as_json, status: :created
        else
          render json: @vertical.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @vertical.destroy
        head :no_content
      end

      private

        def vertical_params
          params.permit(:name, :user_id)
        end
        def set_vertical
          @vertical = Vertical.find(params[:id])
        end

    end
  end
end
