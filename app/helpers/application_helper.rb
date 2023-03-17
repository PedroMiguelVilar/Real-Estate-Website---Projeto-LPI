module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction, search: params[:search], situacao: params[:situacao], type: params[:type], total_quartos: params[:total_quartos], min_price: params[:min_price], max_price: params[:max_price] }, { class: css_class }
  end
  
end
