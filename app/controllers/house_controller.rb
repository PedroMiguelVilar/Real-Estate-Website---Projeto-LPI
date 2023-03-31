
require 'will_paginate/array'

class HouseController < ApplicationController

    def index
        render :index
    end

    def contact
        render :contact
    end

    def property
        render :'property-grid'
    end

    def about
      render :about
    end

    helper_method :sort_column, :sort_direction
    def test
        @houses = House.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 10)
    end

    
    def property_single
      @house = House.find(params[:format])    
      @image_urls = PagesController.new.scrape_single(@house)
      
      if @house.Situacao == 'alugar'
        averages_alugar = House.where(situacao: 'alugar').group(:Localizacao).average(:Price)
        averages_alugar.each do |location, average_price|
          if @house.Localizacao == location
            @averages_single = average_price.round(2)
          end
        end
      elsif @house.Situacao == 'comprar'
        averages_comprar = House.where(situacao: 'comprar').group(:Localizacao).average(:Price)
        averages_comprar.each do |location, average_price|
          if @house.Localizacao == location
            @averages_single = average_price.round(2)
          end
        end
      end
    end
    

    
      helper_method :sort_column, :sort_direction
      def property_grid
        query_params = {}
        query_params[:Situacao] = params[:situacao] if params[:situacao].present?
        query_params[:Type] = params[:type] if params[:type].present?
        query_params[:Total_quartos] = params[:Total_quartos] if params[:Total_quartos].present?
        query_params[:Condicao] = params[:Condicao] if params[:Condicao].present?
        query_params[:Acesso_Mobilidade_Reduzida] = params[:Acesso_Mobilidade_Reduzida] if params[:Acesso_Mobilidade_Reduzida].present?
        query_params[:Arrecadação] = params[:Arrecadação] if params[:Arrecadação].present?
        query_params[:Elevador] = params[:Elevador] if params[:Elevador].present?
        query_params[:Garagem] = params[:Garagem] if params[:Garagem].present?
        query_params[:Estacionamento] = params[:Estacionamento] if params[:Estacionamento].present?
        query_params[:Jardim] = params[:Jardim] if params[:Jardim].present?
        query_params[:Lareira] = params[:Lareira] if params[:Lareira].present?
        query_params[:Recuperador_de_calor] = params[:Recuperador_de_calor] if params[:Recuperador_de_calor].present?
        query_params[:Vidros_duplos] = params[:Vidros_duplos] if params[:Vidros_duplos].present?
        query_params[:Varanda] = params[:Varanda] if params[:Varanda].present?
        query_params[:Terraço] = params[:Terraço] if params[:Terraço].present?
        query_params[:Suite] = params[:Suite] if params[:Suite].present?
        query_params[:Segurança] = params[:Segurança] if params[:Segurança].present?
        query_params[:Piscina] = params[:Piscina] if params[:Piscina].present?
        query_params[:Painéis_Solares] = params[:Painéis_Solares] if params[:Painéis_Solares].present?
        query_params[:Mobília] = params[:Mobília] if params[:Mobília].present?
        query_params[:Logradouro] = params[:Logradouro] if params[:Logradouro].present?


        query_params_1 = {}
        query_params_1[:Total_quartos] = params[:Total_quartos] if params[:Total_quartos].present?
        query_params_1[:Condicao] = params[:Condicao] if params[:Condicao].present?
        query_params_1[:Acesso_Mobilidade_Reduzida] = params[:Acesso_Mobilidade_Reduzida] if params[:Acesso_Mobilidade_Reduzida].present?
        query_params_1[:Arrecadação] = params[:Arrecadação] if params[:Arrecadação].present?
        query_params_1[:Elevador] = params[:Elevador] if params[:Elevador].present?
        query_params_1[:Garagem] = params[:Garagem] if params[:Garagem].present?
        query_params_1[:Estacionamento] = params[:Estacionamento] if params[:Estacionamento].present?
        query_params_1[:Jardim] = params[:Jardim] if params[:Jardim].present?
        query_params_1[:Lareira] = params[:Lareira] if params[:Lareira].present?
        query_params_1[:Recuperador_de_calor] = params[:Recuperador_de_calor] if params[:Recuperador_de_calor].present?
        query_params_1[:Vidros_duplos] = params[:Vidros_duplos] if params[:Vidros_duplos].present?
        query_params_1[:Varanda] = params[:Varanda] if params[:Varanda].present?
        query_params_1[:Terraço] = params[:Terraço] if params[:Terraço].present?
        query_params_1[:Suite] = params[:Suite] if params[:Suite].present?
        query_params_1[:Segurança] = params[:Segurança] if params[:Segurança].present?
        query_params_1[:Piscina] = params[:Piscina] if params[:Piscina].present?
        query_params_1[:Painéis_Solares] = params[:Painéis_Solares] if params[:Painéis_Solares].present?
        query_params_1[:Mobília] = params[:Mobília] if params[:Mobília].present?
        query_params_1[:Logradouro] = params[:Logradouro] if params[:Logradouro].present?

        has_price = false
        has_year = false

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

        if params[:min_year].present? && params[:max_year].present?
          min_year = params[:min_year].to_i
          max_year = params[:max_year].to_i
          has_year = true
        elsif params[:min_year].present? && !params[:max_year].present?
          max_year = 9999999999
          min_year = params[:min_year].to_i
          has_year = true
        elsif !params[:min_year].present? && params[:max_year].present?
          min_year = 0
          max_year = params[:max_year].to_i
          has_year = true
        end

        if(has_year == true)
          if min_year < max_year
            query_params[:Ano_de_Construcao] = (min_year..max_year)
          else
            params[:min_year] = max_year
            params[:max_year] = max_year
            query_params[:Ano_de_Contrucao] = (min_year..max_year)
          end
        end


      if params[:search].present?
        @houses = House.where(query_params).where("Localizacao LIKE ?", "%#{params[:search]}%")
                       .order(sort_column + " " + sort_direction)
                       .paginate(page: params[:page], per_page: 9)
        @houses_map = House.where(query_params).where("Localizacao LIKE ?", "%#{params[:search]}%")
                       .order(sort_column + " " + sort_direction)
      elsif query_params_1.present? # added check for presence of query parameters
        @houses = House.where(query_params)
                       .order(sort_column + " " + sort_direction)
                       .paginate(page: params[:page], per_page: 9)
        @houses_map = House.where(query_params)
                       .order(sort_column + " " + sort_direction)
      else # handle case where no query parameters are present
        @houses = House.none.paginate(page: params[:page], per_page: 9)
        @houses_map = []
      end

      @image_urls = PagesController.new.scrape(@houses)

    end
    
    private
  
    def sort_column
      House.column_names.include?(params[:sort]) ? params[:sort] : "Id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
