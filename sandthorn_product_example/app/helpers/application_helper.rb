module ApplicationHelper

    def nav_link(link_text, link_path)
      class_name = current_page?(link_path) ? 'active' : nil

      content_tag(:li, :class => class_name) do
        link_to link_text, link_path
      end
    end
    def humanized_event_data event_data
    	output = ""
    	event_data.each_pair do |key, value|
    		if value.is_a? Array
    			next if value.empty?
    			output += head_row(key)
    			output = value.inject(output) { |o,e| o + hash_to_tr(e) }	
    		else
    			output += create_row key,value
    		end
    	end
    	"<table class='table table-condensed'>" + output + "</table>"
    end
    def hash_to_tr hash
    	hash.inject("") { |tail,head| tail + create_row(head[0],head[1]) }
    end
    def create_row label, value
    	"<tr><td>#{label}:</td><td>#{value}</td></tr>"
    end
    def head_row label
    	"<tr class='active center'><th colspan='2' class='text-center'>#{label}</th></tr>"
    end
end
