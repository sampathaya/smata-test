module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_request!
      before_action :set_category, only: %i[destroy show update]

      def index
        @categories = Category.all
        render json: CategoriesRepresenter.new(@categories).as_json
      end

      def show
        render json: CategoryRepresenter.new(@category).as_json
      end

      def create
        @category = Category.new(category_params)
        if @category.save
          render json: CategoryRepresenter.new(@category).as_json, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        @category.update(category_params)
        head :no_content
      end

      def destroy
        @category.destroy
        head :no_content
      end

      private

        def category_params
          params.permit(:name, :state, :vertical_id)
        end
        def set_category
          @category = Category.find(params[:id])
        end
    end
  end
end
