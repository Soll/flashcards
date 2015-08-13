require "open-uri"
require "nokogiri"

doc = Nokogiri::HTML(open("http://www.languagedaily.com/learn-german/vocabulary/common-german-words"))

row = doc.xpath("//tr")
	
row.each do |cell|
  nodes_count = 0;
	cell.css("td").take(3).each do |node| 
	  case nodes_count
	    when 0 
	      @id = node.text.split(".").first.to_i
	    when 1
	      @o_t = node.text
	    when 2
	     @t_t = node.text
	  end
	    
	    nodes_count = nodes_count + 1  
	  end
	Card.create(id: @id, original_text: @o_t, translated_text: @t_t, review_date: Time.now, user_id: 0, category_id: 1)
end
