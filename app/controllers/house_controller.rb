
require 'will_paginate/array'

class HouseController < ApplicationController

    def index
        render :index
    end
    def contact
        render :contact
    end
    def about
        render :about
    end

    helper_method :sort_column, :sort_direction
    def test
        @houses = House.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
    end

      helper_method :sort_column, :sort_direction
      def search
        query_params = {}
        query_params[:Situacao] = params[:situacao] if params[:situacao].present?
        query_params[:Type] = params[:type] if params[:type].present?
        query_params[:'Total_quartos'] = params[:total_quartos] if params[:total_quartos].present?
      
        has_price = false

        if params[:min_price].present? && params[:max_price].present?
          min_price = params[:min_price].to_i
          max_price = params[:max_price].to_i
          has_price = true
        elsif params[:min_price].present? && !params[:max_price].present?
          max_price = 9999999999
          min_price = params[:min_price].to_i
          has_price = true
        elsif !params[:min_price].present? && params[:max_price].present?
          min_price = 0
          max_price = params[:max_price].to_i
          has_price = true
        end
        
        if(has_price == true)
          if min_price < max_price
            query_params[:'Price'] = (min_price..max_price)
          else
            params[:min_price] = max_price
            params[:max_price] = min_price
            query_params[:'Price'] = (min_price..max_price)
          end
        end

      if params[:search].present?
        @houses = House.where(query_params).where("Localizacao LIKE ?", "%#{params[:search]}%")
                       .order(sort_column + " " + sort_direction)
                       .paginate(page: params[:page], per_page: 10)
        @houses_map = House.where(query_params).where("Localizacao LIKE ?", "%#{params[:search]}%")
                       .order(sort_column + " " + sort_direction)
      elsif query_params.present? # added check for presence of query parameters
        @houses = House.where(query_params)
                       .order(sort_column + " " + sort_direction)
                       .paginate(page: params[:page], per_page: 10)
        @houses_map = House.where(query_params)
                       .order(sort_column + " " + sort_direction)
      else # handle case where no query parameters are present
        @houses = House.none.paginate(page: params[:page], per_page: 10)
        @houses_map = []
      end
    end
    
    private
  
    def sort_column
      House.column_names.include?(params[:sort]) ? params[:sort] : "Id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    
end
