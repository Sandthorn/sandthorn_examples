module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def humanized_event_data event_data
    rows = event_data.each_pair.flat_map do |key, value|
      if value.is_a?(Array) && !value.empty?
        handle_array_attribute(key, value)
      else
        create_row(key, value)
      end
    end
    content_tag(:table, class: ["table", "table-condensed"]) do
      rows.join.html_safe
    end
  end

  def handle_array_attribute(key, array)
    rows = array.flat_map { |hash| hash.each_pair.map { |k,v| create_row(k,v) }  }
    return [head_row(key), *rows]
  end

  def create_row label, value
    content_tag(:tr) do
      [content_tag(:td, label), content_tag(:td, value)].join.html_safe
    end
  end

  def head_row label
    content_tag(:tr, class: [:active, :center]) do
      content_tag(:th, label, sclass: "text-center", colspan: 2)
    end
  end
end
